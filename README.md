# Samsung Gear 360 to Kodak ORBIT360 format converter

This script allows videos taken with a Samsung Gear 360 to be stiche and edited using the "[PIXPRO 360 VR SUITE](https://kodakpixpro.com/support/downloads/)" program, used for the KODAK ORBIT360 cameras.

Requirements:
- [ffmpeg](https://ffmpeg.org/download.html)
- [mp4edit](https://www.bento4.com/downloads/)

Usage:
```.\gear360-to-orbit360.ps1 -input_file <input_file> [-output_file <output_file>] [-metadata_dir_path <metadata_dir_path>] [-ffmpeg_path <ffmpeg_path>] [-mp4edit_path <mp4edit_path>]```

Example usage:
```.\gear360-to-orbit360.ps1 -input_file .\video.MP4 -metadata_dir_path .\metadata\ -ffmpeg_path .\ffmpeg\ffmpeg.exe -mp4edit_path .\bento4\mp4edit.exe```

If no output filename is given, the default output filename will be the same as the input name with ```_processed``` appended.

## Why
I had an ORBIT360 camera that I really liked. The software provided to stitch the videos together was really simple to use and did most of the things I needed to do. However during a motorcycle roadtrip to the USA the camera crapped out and stopped working. So I got a used Samsung Gear 360 from eBay as a replacement.

I really like the Gear 360 too, but I wasn't satisfied with the options available to stitch the videos, so I found a way to stitch the videos with a software I know and like.

## How
The ORBIT360 inserts some metadata in the MP4 files it generates. If this data is absent from the file, the stitching software refuses to open the file.

This script resizes the video to the same resolution as an ORBIT360 file, It then copies the folloing atom keys and their original values from a source ORBIT360 file into the Gear 360 file:
- ```moov/udta/©fmt```: Contains the string "JK Imaging Ltd."
- ```moov/udta/©inf```: Contains the string "KODAK PIXPRO ORBIT 360 4K"
- ```moov/udta/m cm```: Not quite sure what this is used for
- ```moov/udta/m vr```: Not quite sure what this is used for
- ```moov/udta/SNum```: Seems to contain the serial number of the camera on which the source video was taken
- ```moov/udta/rads```: Not quite sure what it does, but if this key is ommited, the software only shows video from one lens

## macOS

Download the pixpro installer and install it, you will be told it is untrusted, close the warning, open System Settings > Privacy & Security, scroll down to the bottom and you will see a message saying how it stopped the app from opening and a button saying "open anyway". Click it, the installer will throw up some more expired certificate warnings, but keep ignoring them.

It is old software that isn't maintained, so this sort of thing is expected.

**If you have any concerns, then do not install, everything you do here is at your own risk**

Make sure you have the requirements installed, easiest way is through Homebrew, so install that first using the instructions on https://brew.sh/ 

When you have brew installed, open a terminal and use this command to install ffmpeg and mp4edit

```
brew install ffmpeg bento4
```

Navigate to the folder you downloaded this repo into and make the shell script executable 

```
chmod +x gear360-to-orbit360.sh
```

then to run the script

```
./gear360-to-orbit360.sh -i input.mp4 -o output.mp4
```



## Thanks
- [MP4 Inspector](https://sourceforge.net/projects/mp4-inspector/)
- [The bento4 project](https://github.com/axiomatic-systems/Bento4)
- [JK Imaging Ltd.](https://kodakpixpro.com/about-jk-imaging/)
