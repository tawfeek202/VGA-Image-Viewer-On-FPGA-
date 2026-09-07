from PIL import Image


def convert_image_to_mif(input_path, output_path):
    img = Image.open(input_path).convert("RGB")
    img = img.resize((320, 240))
    pixels = img.load()

    with open(output_path, "w") as f:
        f.write("DEPTH = 76800;\n")  # 320 * 240
        f.write("WIDTH = 24;\n")  # 8 bits each for R, G, B
        f.write("ADDRESS_RADIX = UNS;\n")
        f.write("DATA_RADIX = HEX;\n")
        f.write("CONTENT BEGIN\n")

        addr = 0
        for y in range(240):
            for x in range(320):
                r, g, b = pixels[x, y]
                hex_val = f"{r:02x}{g:02x}{b:02x}"
                f.write(f"{addr} : {hex_val};\n")
                addr += 1

        f.write("END;\n")
    print(f"Successfully generated {output_path}")


convert_image_to_mif("Car.jpg", "image_data_320x240.mif")
