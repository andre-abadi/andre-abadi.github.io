---
layout: default
title: Unraid HBA Research
date: 2022-06-06 22:00:00 +0800
tags:
---

# Purpose
- Identify the best expansion card to add extra SATA ports to my whitebox UnRaid Serve

# References
- [Ebay: LSI 6Gbps SAS SATA 9211-8i IT Mode ZFS FreeNAS unRAID + 2*SFF-8087 SATA AU](https://www.ebay.com.au/itm/133499032993?hash=item1f152995a1:g:FHUAAOSwfhZfP5a0)
- [Ebay: DELL H310 6Gbps FW:P20 9211-8i IT Mode ZFS FreeNAS unRAID 2* SFF-8087 SATA AU](https://www.ebay.com.au/itm/144313230513?epid=17048919657&hash=item2199bd24b1:g:hX8AAOSwvZ9hpz86)
- [OCAU: HBA's - Dell Perc 310 vs LSI 211 8i](https://forums.overclockers.com.au/threads/hbas-dell-perc-310-vs-lsi-211-8i.1306456/#post-18975631)
- [ServeTheHome: LSI RAID Controller and HBA Complete Listing Plus OEM Models](https://forums.servethehome.com/index.php?threads/lsi-raid-controller-and-hba-complete-listing-plus-oem-models.599/)


# Actions
- Google the differences
- Best [posting from OCAU](https://forums.overclockers.com.au/threads/hbas-dell-perc-310-vs-lsi-211-8i.1306456/#post-18975631) had the below:
>tl/dr: they're both the same and one can be turned into the other. It'll run flawlessly on Truenas (the new freenas), OMV, unRAID etc.
>
>Longer:
>
>A H310 and an LSI 9211 are exactly the same, save for OEM firmware. Typically the OEM variants of cards are focussed on being RAID (or IR) cards where the original designer (LSI, now broadcom) made a range of cards that were flexible with being a RAID (IR) or HBA (IT) by changing only the firmware. Take a look here for equivalences and notes on what can be turned into what
>
>https://forums.servethehome.com/ind...and-hba-complete-listing-plus-oem-models.599/
>
>If you just want ports you can use RAID or HBA but the HBA is simpler. In a RAID (even ones advertised with JBOD modes) card you'll typically need to make each disk an array of its own. With an HBA, they'll just appear to the operating system. You can also flash firmware only and not the BIOS to a card to make booting faster if you just want ports available after boot (ie not needing to boot from one of the disks attached to the card) if you want. This can save many minutes of boot time for some cards if that's important to you.
>
>An HBA will also get you SMART data from an attached SATA disk, where you can't generally get that from a RAID attachment.
>
>I've used a lot of LSI cards from various OEMs including IBM and fujitsu, but i've not used an H310. I do have an H810 however which i cross flashed to an LSI SAS2308 HBA but it involved sticky tape over some pins since I didn't have a dell server to plug it into. I don't think you'll have that problem with an H310. Simplest answer to your question is to use the link I provided, find an HBA card with the number of ports and position of the ports that you want and then buy the cheapest variant you can find.
- LSI 9211 and Dell H310 are at price parity
- LSI appears to be the original with the Dell appearing to be a rebrand
- Dell appears to have some hardware hacks required (potential sticky tape over pins) but this does not appear to be a factor for the LSI cards
- Check of [ServeTheHome link (via previous OCAU link)](https://forums.servethehome.com/index.php?threads/lsi-raid-controller-and-hba-complete-listing-plus-oem-models.599/) shows `LSI SAS 9211-8i` has OEM model `LSI SAS 9210-8i` and also a single  port version `LSI SAS 9211-4i`
- [Ebay Listing](https://www.ebay.com.au/itm/133499032993?hash=item1f152995a1:g:FHUAAOSwfhZfP5a0) shows many more (204 vs 10) of the LSI sold than the Dells, so likely more popular in the UnRaid scene

# Reflections
- Should buy a `LSI SAS 9211-8i`
- Definitely no good reason to get anything better if running spinners (will be)
- Dell model, while having Dell familiarity, probably just adds complications