//===-- Unittests for getuid ----------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "src/unistd/getuid.h"
#include "test/UnitTest/Test.h"

TEST(LlvmLibcGetUidTest, SmokeTest) {
  // getuid always succeeds. So, we just call it as a smoke test.
  LIBC_NAMESPACE::getuid();
}
