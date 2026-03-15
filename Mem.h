#pragma once
#include "MemoryManager.h"

// Простейший менеджер памяти, использует ::new и ::delete
class Mem: public MemoryManager
{
public:
    Mem(size_t sz): MemoryManager(sz) {}

    void* allocMem(size_t sz)
    {
        if(sz > this->size())
            return nullptr; //Запрошено больше памяти чем есть в бюджете
        return new char[sz];
    }

    void freeMem(void* ptr)
    {
        delete[] static_cast<char*>(ptr);
    }
};
