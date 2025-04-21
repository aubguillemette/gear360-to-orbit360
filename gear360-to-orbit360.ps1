param (
	[string]$input_file,
	[string]$output_file,
	[string]$metadata_dir_path = "metadata",
	[string]$ffmpeg_path = (Get-Command ffmpeg -ErrorAction SilentlyContinue).Path,
	[string]$mp4edit_path = (Get-Command mp4edit -ErrorAction SilentlyContinue).Path
)

if (-not $input_file) {
	Write-Host "Usage: gear360-to-orbit360.ps1 -input_file <input_file> [-output_file <output_file>] [-metadata_dir_path <metadata_dir_path>] [-ffmpeg_path <ffmpeg_path>] [-mp4edit_path <mp4edit_path>]"
	exit 1
}

if (-not (Test-Path -Path $metadata_dir_path -PathType Container)) {
	Write-Host "Metadata directory does not exist: $metadata_dir_path"
	exit 1
}

if (-not $ffmpeg_path) {
	Write-Host "ffmpeg not found. (You can set the ffmpeg_path parameter to specify the path to ffmpeg)"
	exit 1
}
if (-not $mp4edit_path) {
	Write-Host "mp4edit not found. (You can set the mp4edit_path parameter to specify the path to mp4edit)"
	exit 1
}

if (-not $output_file) {
	$output_file = "$($input_file.Substring(0, $input_file.LastIndexOf('.')))_processed.mp4"
}

if (-not (Test-Path -Path $input_file -PathType Leaf)) {
	Write-Host "Input file does not exist: $input_file"
	exit 1
}

if ($metadata_dir_path.EndsWith("\")) {
	$metadata_dir_path = $metadata_dir_path.TrimEnd("\")
}

$remuxed_file = "$($input_file.Substring(0, $input_file.LastIndexOf('.')))_remuxed.mp4"

& $ffmpeg_path -i $input_file -s 3840x1920 -c:a copy $remuxed_file
& $mp4edit_path --insert moov/udta/:$metadata_dir_path\fmt.udta:0 --insert moov/udta/:$metadata_dir_path\inf.udta:1 --insert moov/udta/:$metadata_dir_path\SNumSham.udta:2 --insert moov/udta/:$metadata_dir_path\mcm.udta:3 --insert moov/udta/:$metadata_dir_path\mvr.udta:4 --insert moov/udta/:$metadata_dir_path\rads.udta $remuxed_file $output_file
Remove-Item $remuxed_file
