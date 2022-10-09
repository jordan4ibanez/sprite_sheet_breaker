import std.stdio;
import image;
import std.conv;
import std.file: mkdir;

void main() {

    TrueColorImage masterImage;
    int size;
    int border;
    int mapSizeX;
    int mapSizeY;

    writeln("Welcome to Sprite Sheet Breaker 1.0.0!\n");

    bool success = false;

    while (!success) {
        write("Please tell me where your spritesheet is located: ");
        stdout.flush();

        string directory = readln('\n');
        directory = directory[0..cast(ulong)directory.length-1]; // remove \n

        try {
            masterImage = loadImageFromFile(directory).getAsTrueColorImage();

            success = true;

            writeln(directory, " has been uploaded successfully!\n");
            
        } catch (Exception e) {
            writeln("\nIt appears that you have made a typo. There is no file at ", directory, ". Let's try this again.\n");
        }
    }

    success = false;

    while (!success) {
        write("Please tell me what the grid size is in pixels (per texture): ");
        stdout.flush();

        string sizeLiteral = readln('\n');

        try {
            size = parse!int(sizeLiteral);
            success = true;
            writeln();
        } catch (Exception e) {
            writeln("\nIt appears you have made a typo. Let's try this again.\n");
        }
    }

    success = false;

    while (!success) {
        write("Please tell me what the border size is in pixels: ");
        stdout.flush();

        string sizeLiteral = readln('\n');

        try {
            border = parse!int(sizeLiteral);
            success = true;
            writeln();
        } catch (Exception e) {
            writeln("\nIt appears you have made a typo. Let's try this again.\n");
        }
    }

    success = false;

    while (!success) {
        write("Please tell me what the map width is in tiles: ");
        stdout.flush();

        string sizeLiteral = readln('\n');

        try {
            mapSizeX = parse!int(sizeLiteral);
            success = true;
            writeln();
        } catch (Exception e) {
            writeln("\nIt appears you have made a typo. Let's try this again.\n");
        }
    }

    success = false;

    while (!success) {
        write("Please tell me what the map height is in tiles: ");
        stdout.flush();

        string sizeLiteral = readln('\n');

        try {
            mapSizeY = parse!int(sizeLiteral);
            success = true;
            writeln();
        } catch (Exception e) {
            writeln("\nIt appears you have made a typo. Let's try this again.\n");
        }
    }

    // 37 width
    // 28 height

    writeln("Beginning conversion!\n");

    TrueColorImage workerImage = new TrueColorImage(size, size);

    int output = 0;

    try {
        mkdir("output_textures");
    } catch(Exception e) {}

    

    foreach (baseY; 0..mapSizeY) {
            
        int basePixelY = baseY == 0 ? 0 : (baseY * size) + border;

        foreach (baseX; 0..mapSizeX) {

            int basePixelX = baseX == 0 ? 0 : (baseX * size) + border;

            foreach (x; 0..size) {
                foreach (y; 0..size) {

                    workerImage.setPixel(
                        x,
                        y,
                        masterImage.getPixel(basePixelX + x, basePixelY + y)
                    );
                }
            }

            writeImageToPngFile("output_textures/" ~ to!string(output) ~ "_texture.png", workerImage);

            output++;


        }
    }
}
