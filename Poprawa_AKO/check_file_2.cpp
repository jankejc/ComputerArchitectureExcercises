// Your First C++ Program

#include <iostream>
//#include <processenv.h>
#include <windows.h>

int main()
{
    const wchar_t* lpFileName[12] = { L"NWD_dok.asm" };
    wchar_t* lpBuffer[255];
    wchar_t* lpFilePart;
    int number = -1;
    //number = SearchPathW(NULL, *lpFileName, NULL, 255, *lpBuffer, &lpFilePart);
    std::cout << "Hello World!";
    return 0;
}