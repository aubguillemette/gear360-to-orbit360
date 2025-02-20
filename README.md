# Samsung Gear 360 to Kodak ORBIT360 format converter

This script allows videos taken with a Samsung Gear 360 to be stiche and edited using the "PIXPRO 360 VR SUITE" program, used for the KODAK ORBIT360 cameras.

Requirements:
- (ffmpeg)[https://ffmpeg.org/download.html]
- (mp4edit)[https://www.bento4.com/downloads/]

Usage:
```.\gear360-to-orbit360.ps1 -input_file <input_file> [-output_file <output_file>] [-metadata_dir_path <metadata_dir_path>] [-ffmpeg_path <ffmpeg_path>] [-mp4edit_path <mp4edit_path>]```

Example usage:
```.\gear360-to-orbit360.ps1 -input_file .\video.MP4 -metadata_dir_path .\metadata\ -ffmpeg_path .\ffmpeg\ffmpeg.exe -mp4edit_path .\bento4\mp4edit.exe```

If no output filename is given, the default output filename will be the same as the input name with ```_processed``` appended.
