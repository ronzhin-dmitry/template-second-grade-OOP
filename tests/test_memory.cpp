#define BOOST_TEST_MODULE MemoryManagerSmokeTests
#include <boost/test/unit_test.hpp>

#include "Mem.h"
#include "MemoryManager.h"

BOOST_AUTO_TEST_CASE(memory_manager_reports_requested_pool_size)
{
    Mem mem(1024);
    BOOST_TEST(mem.size() == 1024u);
}

BOOST_AUTO_TEST_CASE(mem_allocates_and_frees_block)
{
    Mem mem(256);
    void* ptr = mem.allocMem(64);

    BOOST_TEST(ptr != nullptr);

    mem.freeMem(ptr);
}

BOOST_AUTO_TEST_CASE(mem_returns_nullptr_for_too_large_allocation)
{
   Mem mem(100);
   void* ptr = mem.allocMem(200); // Запрашиваем больше памяти, чем доступно

   BOOST_TEST(ptr == nullptr); // Ожидаем nullptr
}