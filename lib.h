#ifndef LIB_H__
#define LIB_H__

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#ifndef __cplusplus
// stdbool.h is deprecated in C++, cstdbool is deprecated in C++17 and removed in the draft C++20 standard
#include <stdbool.h>
#else
#include <cstdint>
#include <cstdbool>
#endif

#ifdef __cplusplus
}
#endif // __cplusplus

#endif // LIB_H__