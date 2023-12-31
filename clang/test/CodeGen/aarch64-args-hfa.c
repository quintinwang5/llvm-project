// RUN: %clang_cc1 -triple aarch64 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,CHECK-AAPCS
// RUN: %clang_cc1 -triple arm64-apple-ios7.0 -target-abi darwinpcs -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,CHECK-DARWIN
// RUN: %clang_cc1 -triple aarch64-linux-gnu -emit-llvm -o - -x c %s | FileCheck %s --check-prefixes=CHECK,CHECK-AAPCS

typedef struct {
  float v[2];
} S0;

// CHECK-AAPCS:  define{{.*}} float @f0([2 x float] alignstack(8) %h.coerce)
// CHECK-DARWIN: define{{.*}} float @f0([2 x float] %h.coerce)
float f0(S0 h) {
  return h.v[0];
}

// CHECK: define{{.*}} float @f0_call()
// CHECK-AAPCS: %call = call float @f0([2 x float] alignstack(8) %0)
// CHECK-DARWIN: %call = call float @f0([2 x float] %0)
float f0_call(void) {
  S0 h = {1.0f, 2.0f};
  return f0(h);
}
typedef struct {
  double v[2];
} S1;
// CHECK-AAPCS: define{{.*}} double @f1([2 x double] alignstack(8) %h.coerce)
// CHECK-DARWIN: define{{.*}} double @f1([2 x double] %h.coerce)
double f1(S1 h) {
  return h.v[0];
}

// CHECK: define{{.*}} double @f1_call()
// CHECK-AAPCS: %call = call double @f1([2 x double] alignstack(8) %0
// CHECK-DARWIN: %call = call double @f1([2 x double] %0
double f1_call(void) {
  S1 h = {1.0, 2.0};
  return f1(h);
}
typedef struct {
  __attribute__((__aligned__(16))) double v[2];
} S2;

// CHECK-AAPCS:  define{{.*}} double @f2([2 x double] alignstack(16) %h.coerce)
// CHECK-DARWIN: define{{.*}} double @f2([2 x double] %h.coerce)
double f2(S2 h) {
  return h.v[0];
}

// CHECK: define{{.*}} double @f2_call()
// CHECK-AAPCS:  %call = call double @f2([2 x double] alignstack(16) %0)
// CHECK-DARWIN: %call = call double @f2([2 x double] %0
double f2_call(void) {
  S2 h = {1.0, 2.0};
  return f2(h);
}

typedef struct {
  __attribute__((__aligned__(32))) double v[4];
} S3;

// CHECK-AAPCS:  define{{.*}} double @f3([4 x double] alignstack(16) %h.coerce)
// CHECK-DARWIN: define{{.*}} double @f3([4 x double] %h.coerce)
double f3(S3 h) {
  return h.v[0];
}

// CHECK: define{{.*}} double @f3_call()
// CHECK-AAPCS:  %call = call double @f3([4 x double] alignstack(16) %0)
// CHECK-DARWIN: %call = call double @f3([4 x double] %0
double f3_call(void) {
  S3 h = {1.0, 2.0};
  return f3(h);
}
