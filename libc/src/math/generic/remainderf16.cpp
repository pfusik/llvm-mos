//===-- Implementation of remainderf16 function ---------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "src/math/remainderf16.h"
#include "src/__support/FPUtil/DivisionAndRemainderOperations.h"
#include "src/__support/common.h"
#include "src/__support/macros/config.h"

namespace LIBC_NAMESPACE_DECL {

LLVM_LIBC_FUNCTION(float16, remainderf16, (float16 x, float16 y)) {
  int quotient;
  return fputil::remquo(x, y, quotient);
}

} // namespace LIBC_NAMESPACE_DECL
