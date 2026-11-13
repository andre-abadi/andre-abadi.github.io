---
layout: default
title: Ocular IQ CT Clamp Readings in Home Assistant
date: 2026-11-13 07:19:00 +0800
tags:
- home automation
- electric vehicle
---

# Purpose
- Replicate Ocular IQ smart charging modes in Home Assistant via local OCPP.

# References
- [Ocular LTE Plus V3 Home Assistant Integration Guide](https://evse.com.au/wp-content/uploads/Ocular-LTE-Plus-V3-Home-Assistant-Integration-Guide.pdf)
- [Ocular IQ Home Solar Installation Guide](https://ocularcharging.com.au/wp-content/uploads/2025/09/IQ-Home-Solar-Installation-Guide-v2.7.pdf)
- [Home Assistant OCPP Documentation](https://home-assistant-ocpp.readthedocs.io/en/latest/)

# Current Setup
- Ocular IQ Single Phase with CT clamp
- Fully provisioned to work with Ocular IQ app showing CT clamp readings.

# Initial OCPP Cutover
- Installed [OCPP](https://github.com/lbbrhzn/ocpp) via Home Assistant Marketplace.
    - Default settings.
- Accessed the web interface at `http://IP`
    - Username: `install`
    - Password: either `installer123` or `Evcharging123` (the latter if your provisioner changed it per the Installation Guide).
- Made no changes to `Advanced / OCPP`
- Under `Basic / Server`:
    - Endpoint
        - Domain: `[HASS-IP]
        - Port: `9000`
        - Path: `central`
        - Identity / Serial No: `Ocular-IQ-Garage`
    - Security
        - Security Profile: `ws`
    - Reference URL: `ws://[HASS-IP]:9000/central/Ocular-IQ-Garage`
- This resulted in the charger appearing in Home Assistant.

# Investigation

- Primary Controls seemed working:
    - `Availability` toggle
    - `Charge Control` toggle (unknown function)
    - `Maximum Current` slider 0-32A (for my single phase charger)
    - `Session Current Limit` greeyed our slider no values (possibly only active during charge or a read-only sensor?)
- All sensors came up as Unknown:
    - `Current Import`
    - `Current Offered`
    - `Energy Active Import Register`
    - `Energy Meter Start`
    - `Energy Session`
    - `SoC`
    - `Stop Reason`
    - `Temperature`
    - `Time Session`
    - `Transation Id`
    - `Voltage`
- Configuration options:
    - `Reset` button
    - `Unlock` button
- All Diagnostic sensors seemed working except `Status Firmware`, `Timestamp Config Response`, and `Tiemstamp Data Transfer`.
- **Many sensors and diagnostics came through but no CT clamp.**
- Ran `Tools/Actions` and the following YAML action:
    ```yaml
    action: ocpp.get_configuration
    data:
        devid: charger
    ```
- Found matching OCPP configs from the frontend:
    - `sDomain: [HASS-IP]`
    - `sPort: '9000'`
    - `sURL: /central`
    - `Id: Ocular-IQ-Garage`
- Disappointingly found my Wifi password in plaintext under `wPwd`.
- Found the following 'b' OCPP server settings not exposed in the web interface:
    - `bsDomain: ocpp.ocularcharging.com.au`
    - `bsPort: '9113'`
    - `bsURL: /ocpp/energy`
    - `bId: [SERIAL]`

- Appears to be like like my [Solaredge Modbus Multi](https://github.com/WillCodeForCats/solaredge-modbus-multi) the CT clamp or its submodule are seperate devices that are just combined for the purpose of the user.
    - Inverter shows up as `SE5000H-[SERIAL]` device
    - Meter shows up as `WND-3Y-400-MB` device
- Tried configuring `bsDomain` to its existing value:
    ```yaml
    action: ocpp.configure
    data:
      devid: charger
      ocpp_key: bsDomain
      value: ocpp.ocularcharging.com.au
    ```
    - Response: `reboot_required: false`
- Tried configuring it to my Home Assistant IP, not yet full cutover but just to see what a value change would do.
    ```yaml
    action: ocpp.configure
    data:
    devid: charger
    ocpp_key: bsDomain
    value: "[HASS-IP]"
    ```
    - Response: `reboot_required: true`
- Rebooted via web interface
- Hass get config
    ```yaml
    action: ocpp.get_configuration
    data:
        devid: charger
    ```
    - `bsDomain: [HASS-IP]`
- Also set the `bsPort`, `bsURL` to match non-*b* entries.
- Set `bId` to `Ocular-IQ-Meter`
- Reboot via web interface
- Nothing new on Home Assistant OCPP debug
- Try matching `bsecurityProfile` from 2 to 0 to match `securityProfile` key.
    ```yaml
    action: ocpp.configure
    data:
    devid: charger
    ocpp_key: bsecurityProfile
    value: 0
    ```
- Reboot via web interface
- Home Assistant debug logs show `[custom_components.ocpp] Charger websocket path=/central/Ocular-IQ-Meter`
- OCPP integration shows option to add new `Open Charge Point Protocol (OCPP)` device so I added it with configuration:
    - Charge point identity: `meter`
    - Everything else default.
- Controls, Sensors and Configuration all unavailable or inapplicable, so disabled them.
- Substantial Diagnostic values do appear suggesting some basic functionality e.g. `Latency Ping` and `Latency Pong` just like the charger itself.

# Interim Findings
- The meter connects as a separate OCPP device and sends vendor-specific `meterValue` data containing CT current, grid power, eco mode, and solar-enabled status.
- The first-phase CT current matched my SolarEdge Modbus reading. Positive `powerToGrid` matched solar export in watts; negative values are assumed to represent import, pending confirmation.
- The existing OCPP integration receives the data but does not expose these values as live sensors. Integration changes are needed to surface them in Home Assistant.
- The meter exposes an `EcoMode` configuration key. Ideally this would become a writable control, but its values and write behaviour still need investigation.
- Next step is to:
    - Render the vendor data in Home Assistant frontend via integration.
    - Ideally make any adjustable settings adjustable in Home Assistant.

# Proof of Concept Sensors Only
1. Install Home Assistant [OCPP custom integration](https://github.com/lbbrhzn/ocpp/blob/main/README.md)
2. Configure integration, redirect OCPP to Home Assistant and verify working
1. Home Assistant action `ocpp.configure` for primary device `charger`:
    - `bsPort` -> `sPort`
    - `bsDomain` -> `sDomain`
    - `bsURL` -> `sURL`
    - `bsecurityProfile` -> `securityProfile`
    - `bId` -> `Ocular-IQ-Meter` or similar to distinguish from `Ocular-IQ-Charger`
2. Add new device that should appear on OCPP custom integration page
3. Enable integration debug loggind and check for lines starting with:
    - `Data transfer received from Ocular-IQ-Meter:`
    - `Connection latency from 'central' to 'Ocular-IQ-Meter':`
4. (Optionally) In Home Assistant device page for the meter, disable all Controls, Sensors, Configuration, and any Diagnostic showing Unknown.
5. Edit `sensor.py` in the OCPP custom integration to add support for the new meter values. Just before `if num_connectors > 1`
    ```python
    if cpid == "meter":
    for metric in (
        "Current.Ocular.Grid",
        "Power.Active.Ocular.Grid",
        "Ocular.EcoMode",
        "Ocular.SolarEnabled",
    ):
        entities.append(
            ChargePointMetric(
                hass,
                central_system,
                cpid,
                _mk_desc(metric),
                connector_id=None,
                charger_device_id=charger_device_id,
            )
        )
    ```
6. Edit `ocppv16.py` and replace the `on_data_transfer_method with:
    ```python
        @on(Action.data_transfer)
    def on_data_transfer(self, vendor_id, **kwargs):
        """Handle a Data transfer request."""
        _LOGGER.debug("Data transfer received from %s: %s", self.id, kwargs)
        self._metrics[0][cdet.data_transfer].value = datetime.now(tz=UTC)
        self._metrics[0][cdet.data_transfer].extra_attr = {vendor_id: kwargs}

        if (
            self.id == "Ocular-IQ-Meter"
            and vendor_id == "IoCharger"
            and kwargs.get("message_id") == "meterValue"
        ):
            try:
                payload = json.loads(kwargs["data"])
                grid = payload["sampledValue"]["powerGrid"][0]
                current = float(grid["current"][0])
                power = float(grid["powerToGrid"])
                eco_mode = payload["ecoMode"]
                solar_enabled = payload["enableSolar"]

                if not math.isfinite(current) or not math.isfinite(power):
                    raise ValueError("Non-finite grid measurement")
                if not isinstance(eco_mode, str) or not isinstance(solar_enabled, bool):
                    raise ValueError("Invalid eco mode or solar-enabled value")

                values = {
                    "Current.Ocular.Grid": (current, "A"),
                    "Power.Active.Ocular.Grid": (power, "W"),
                    "Ocular.EcoMode": (eco_mode, None),
                    "Ocular.SolarEnabled": (
                        "Enabled" if solar_enabled else "Disabled",
                        None,
                    ),
                }
                for key, (value, unit) in values.items():
                    self._metrics[0][key].value = value
                    self._metrics[0][key].unit = unit

                self._async_refresh_metric_entities(list(values))
            except (KeyError, IndexError, TypeError, ValueError) as err:
                _LOGGER.warning("Invalid Ocular meterValue from %s: %s", self.id, err)

        return call_result.DataTransfer(status=DataTransferStatus.accepted.value)
    ```

- This resulted in four new sensors being added to the meter device:
    - `Current.Ocular.Grid` which correlated 95% to the grid current reading from Solaredge Modbus.
    - `Power.Active.Ocular.Grid` which correlated 95% to the grid power reading from Solaredge Modbus.
    - `Ocular.EcoMode` which required further investigation to determine numeric range.
    - `Ocular.SolarEnabled` which required further investigation but may be a sensor indicating that on the charger, `enableSolar` was set to `1`.

# Next Steps
- Determine what combination of `Ocular.EcoMode` and `Ocular.SolarEnabled` values correspond to:
    - Fast Charge: 32A (or as max allowed by charger) with no solar consideration
    - Solar Assist: 6A from grid plus any excess solar energy
    - Solar Only: No grid energy, minimum X excess amps to grid
- Determine if there is a relationship between meter `Ocular.SolarEnabled` and charger `enableSolar` values.
- Identify the setting on the charger that corresponds to *plug and charge* mode where the vehicle starts charging automatically upon being plugged in.

# Mode Mapping Tests
- Set charger `enableSolar` from `1` to `0` and observe changes in `Ocular.SolarEnabled` sensor.
    ```yaml
    action: ocpp.configure
    data:
        devid: charger
        ocpp_key: enableSolar
        value: "0"
    ```
    ```yaml
    reboot_required: true
    ```

- Rebooted via web interface.
- Observed that on meter device, `Ocular.SolarEnabled` changed to `Disabled`!
- Changed it back to `1`
- Observed that on meter device, `Ocular.SolarEnabled` changed back to `Enabled`!
- Set charger `EcoMode` from `1` to `0` and observe changes in meter `Ocular.EcoMode` sensor.
    ```yaml
    action: ocpp.configure
    data:
        devid: charger
        ocpp_key: EcoMode
        value: "0"
    ```
    ```yaml
    reboot_required: true
    ```

- Rebooted via web interface.
- Observed that on meter `Ocular.EcoMode` changed from `PV` to `Fast`, which corresponds to known advertised charge modes!
- Set charger `EcoMode` from `0` to `2` and observe changes in meter `Ocular.EcoMode` sensor.
    ```yaml
    action: ocpp.configure
    data:
        devid: charger
        ocpp_key: EcoMode
        value: "2"
    ```
    ```yaml
    reboot_required: true
    ```

- Rebooted via web interface.
- Observed that on meter `Ocular.EcoMode` changed from `PV` to `PV_plus`, which corresponds to known advertised charge modes!
- So now we know that:
    - `Ocular.EcoMode` sensor on the meter corresponds to the charger's `EcoMode` sensor.
        - `0` on the charger maps to `Fast` on the meter.
        - `1` on the charger maps to `PV` on the meter.
        - `2` on the charger maps to `PV_plus` on the meter.
    - `Ocular.SolarEnabled` sensor on the meter corresponds to the charger's `enableSolar` sensor.
- Appears that the meter simply provides data back to the charger, and all functionality is governed by the charger itself i.e. `ocpp.configure` at the charger changes behaviour **NOT** at the meter.
- The meter acts as a passive observer, and can map certain numerical states from the charger to semi-readable strings for easier interpretation e.g. charger `ecoMode` value of `0` corresponds to meter `EcoMode` value of `Fast`.
