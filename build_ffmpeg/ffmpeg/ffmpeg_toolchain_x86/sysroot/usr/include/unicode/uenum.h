// © 2016 and later: Unicode, Inc. and others.
// License & terms of use: http://www.unicode.org/copyright.html
/*
*******************************************************************************
*
*   Copyright (C) 2002-2013, International Business Machines
*   Corporation and others.  All Rights Reserved.
*
*******************************************************************************
*   file name:  uenum.h
*   encoding:   UTF-8
*   tab size:   8 (not used)
*   indentation:2
*
*   created on: 2002jul08
*   created by: Vladimir Weinstein
*/

#ifndef __UENUM_H
#define __UENUM_H

#include "unicode/utypes.h"

#if U_SHOW_CPLUSPLUS_API
#include "unicode/localpointer.h"

U_NAMESPACE_BEGIN
class StringEnumeration;
U_NAMESPACE_END
#endif   // U_SHOW_CPLUSPLUS_API

/**
 * \file
 * \brief C API: String Enumeration 
 */
 
/**
 * An enumeration object.
 * For usage in C programs.
 * @stable ICU 2.2
 */
struct UEnumeration;
/** structure representing an enumeration object instance @stable ICU 2.2 */
typedef struct UEnumeration UEnumeration;



#if U_SHOW_CPLUSPLUS_API

U_NAMESPACE_BEGIN

/**
 * \class LocalUEnumerationPointer
 * "Smart pointer" class, closes a UEnumeration via uenum_close().
 * For most methods see the LocalPointerBase base class.
 *
 * @see LocalPointerBase
 * @see LocalPointer
 * @stable ICU 4.4
 */
U_DEFINE_LOCAL_OPEN_POINTER(LocalUEnumerationPointer, UEnumeration, uenum_close);

U_NAMESPACE_END

#endif









#if U_SHOW_CPLUSPLUS_API



#endif





#endif
