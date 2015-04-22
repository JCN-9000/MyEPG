Configuring WebGrab+Plus Version 1.1.1:

You are running a release of WebGrab+Plus which is includes two postprocessors that enables to add imdb data to the xmltv output file (MDB) and/or to rearrange it (REX). See the end of this text for some details.

++++++ The Grabber part ++++++

Installing WebGrab+Plus will place all resource-files (config, ini, txt and ico) to C:\ProgramData\ServerCare\WebGrab. This is the programs home working folder. This is also the place were the xmltv outputfile (guide.xml) and the log file will be put. The place of the xmltv file can be changed to suit your needs in the configfile (C:\ProgramData\ServerCare\WebGrab\WebGrab++.config.xml)
Directly after the installation a test run is started. It uses the configfile which comes with the distribution that will grab 1 day of epg data from all available sites in incremental mode. You can interrupt this any time without any consequence for files and settings.

Adapt the config settings to suit your own needs, the file is self explanatary. The most important is to add /change the list of channels for which epg data is grabbed. Read and follow the instructions in the configfile to do that. The most important is to specify the correct <site> attribute value. For each site listed there a corresponding siteini file must be available, eg if the <site> value is laguiatv.com a siteini file laguiatv.com.ini must be available in the program working folder. Every channel can have a different <site> value, allowing to grab epg data from different sites in one run. (This is demonstrated in the config file that is used for the test run). The next important value in the channel list is the <site_id> attribute. This must be equal to the channel identification in the corresponding site. 
For nearly all sites a channel list file (like tvgids.nl.channels.xml) is available in the SiteIni.Pack. 
The most easy way to add channels to your config file is to copy the ones you want from this channel list file into the config file, and to delete the ones you don't need.

Another setting you might want to change is the number of days , e.g. <timespan>6</timespan> gives you a week of epg. Also check the other available settings.

If no siteini file is available for a certain site it must be created. You can either try to make one yourself with the help of the Documentation.V1_0_Beta.pdf file or contact me at <jan_van_straaten@hotmail.com>  or leave a message at the ServerCare.nl WebGrab+Plus page.

+++++++ The MDB postprocessor part +++++++

This MDB postprocessor can be activated by a new entry in WebGrab++.config.xml : <postprocess> (see there for details)

This postprocessor uses two types of resource files : a config file, mdb.config.xml and ini files, currently imdb.com.ask.ini and imdb.com.bing.ini. They will be placed in a separate folder C:\ProgramFiles\ServerCare\Webgrab\mdb by the installer.
With mdb.config.xml, the functionality of the postprocessor can be set by the user. As with WebGrab++.config.xml the file is self explanatory. Besides the obvious setting of the name and path of the target xmltv file and of an optional mdb data file, that can store the data grabbed from imdb with the purpose to reuse this data, the following three settings control mdb postprocessors functions and performance:
A... Selection settings : These determine which of the shows in the xmltv inputfile are selected as a 'candidate' for a possible match in imdb. There are two sets of selection settings, named 'movies' and 'series'. 
B... Matching settings : Determine the criteria which has to be met to consider a 'candidate' to match with an imdb entry.
C... Allocation and Presentation of the imdb data in the xmltv target file. Determines which and where the imdb data will be merged with the xmltv target file. This part of the mdb config file uses the same syntax as for the rex config file (see next) , because the mdb postprocessor makes use of the rex postprocessor automatically for this part. 

The other resource file, with the .ini extension, is needed to grab and scrub the data from public search sites like ask.com and bing.com andfrom the international movie database Imdb.com .Its function is simular to any other siteini file. Unless you are familiar with the syntax and the commands of siteini files it is best not to change them.

+++++++ The REX postprocessor part +++++++

This REX postprocessor can be activated by a new entry in WebGrab++.config.xml : <postprocess> (see there for details)

It uses a separate config file, rex.config.xml, that is placed in a separate folder C:\ProgramFiles\ServerCare\Webgrab\rex by the installer. In it the (re_)allocation of xmltv elements can be specified. This config file also serves as userguide , so read the explanations in it if you plan to use it.
 
Any comments /problems /wishes to the same address are welcome.


good luck      Jan van Straaten