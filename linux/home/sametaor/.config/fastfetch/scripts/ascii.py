import glob
import subprocess
import os

directory = r"/home/sametaor/.config/fastfetch/logos/image/deus_ex/"
png_files = glob.glob(os.path.join(directory, "*.png"))

for image_path in png_files:
    print(f"Processing: {image_path}")
    file_name = os.path.basename(image_path)
    output_file = file_name + ".txt"
    # Add quotes around the path
    cmd = f"ascii-image-converter {image_path} -C -d 40,20 -c | tee -a '/home/sametaor/.config/fastfetch/logos/ascii/deus_ex/{output_file}'"
    result = subprocess.run(cmd, shell=True)
    if result.returncode != 0:
        print(f"Error processing {image_path}")
