// Lean compiler output
// Module: Std.Do.SPred
// Imports: Std.Do.SPred.SVal Std.Do.SPred.SPred Std.Do.SPred.Notation Std.Do.SPred.Laws Std.Do.SPred.DerivedLaws
#include <lean/lean.h>
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wunused-parameter"
#pragma clang diagnostic ignored "-Wunused-label"
#elif defined(__GNUC__) && !defined(__CLANG__)
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wunused-label"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#endif
#ifdef __cplusplus
extern "C" {
#endif
lean_object* initialize_Std_Do_SPred_SVal(uint8_t builtin, lean_object*);
lean_object* initialize_Std_Do_SPred_SPred(uint8_t builtin, lean_object*);
lean_object* initialize_Std_Do_SPred_Notation(uint8_t builtin, lean_object*);
lean_object* initialize_Std_Do_SPred_Laws(uint8_t builtin, lean_object*);
lean_object* initialize_Std_Do_SPred_DerivedLaws(uint8_t builtin, lean_object*);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_Std_Do_SPred(uint8_t builtin, lean_object* w) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
res = initialize_Std_Do_SPred_SVal(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Std_Do_SPred_SPred(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Std_Do_SPred_Notation(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Std_Do_SPred_Laws(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Std_Do_SPred_DerivedLaws(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
