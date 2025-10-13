#include <windows.h>
#include <stdio.h>

int main() {
    //path to physical drive
    const char* drivePath = "\\\\.\\PhysicalDrive1"; //change to target disk

    //load boot binary
    FILE* bootFile = fopen("bootloader.bin", "rb");
    if (!bootFile) {
        printf("Failed to open bootloader.bin\n");
        return 1;
    }

    BYTE mbr[512];
    size_t bytesRead = fread(mbr, 1, 512, bootFile);
    fclose(bootFile);

    if (bytesRead != 512) {
        printf("Bootloader must be exactly 512 bytes0\n");
        return 1;
    }

    //open raw disk
    HANDLE hDisk = CreateFileA(
        drivePath,
        GENERIC_WRITE,
        FILE_SHARE_READ | FILE_SHARE_WRITE,
        NULL,
        OPEN_EXISTING,
        0,
        NULL
    );

    if (hDisk == INVALID_HANDLE_VALUE) {
        printf("Failed to open disk. Error: %lu\n", GetLastError());
        return 1;
    }

    //move to start of disk
    LARGE_INTEGER li;
    li.QuadPart = 0;
    SetFilePointerEx(hDisk, li, NULL, FILE_BEGIN);
    
    //best part
    DWORD bytesWritten;
    BOOL success = WriteFile(hDisk, mbr, 512, &bytesWritten, NULL);
    if (!success || bytesWritten != 512) {
        printf("Failed to write MBR. Error: %lu\n", GetLastError());
    } else {
        printf("MBR overwritten successfully. \n");
    }

    CloseHandle(hDisk);
    return 0;
}