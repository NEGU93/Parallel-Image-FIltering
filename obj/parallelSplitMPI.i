# 1 "src/parallelSplitMPI.c"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "src/parallelSplitMPI.c"
# 1 "src/parallelSplitMPI.h" 1



# 1 "/users/profs/2016/francois.trahay/soft/install/openmpi-2.0.1/include/mpi.h" 1
# 228 "/users/profs/2016/francois.trahay/soft/install/openmpi-2.0.1/include/mpi.h"
# 1 "/usr/lib/gcc/i386-redhat-linux/4.1.2/include/stddef.h" 1 3 4
# 152 "/usr/lib/gcc/i386-redhat-linux/4.1.2/include/stddef.h" 3 4
typedef int ptrdiff_t;
# 214 "/usr/lib/gcc/i386-redhat-linux/4.1.2/include/stddef.h" 3 4
typedef unsigned int size_t;
# 326 "/usr/lib/gcc/i386-redhat-linux/4.1.2/include/stddef.h" 3 4
typedef long int wchar_t;
# 229 "/users/profs/2016/francois.trahay/soft/install/openmpi-2.0.1/include/mpi.h" 2
# 261 "/users/profs/2016/francois.trahay/soft/install/openmpi-2.0.1/include/mpi.h"
# 1 "/users/profs/2016/francois.trahay/soft/install/openmpi-2.0.1/include/mpi_portable_platform.h" 1
# 262 "/users/profs/2016/francois.trahay/soft/install/openmpi-2.0.1/include/mpi.h" 2
# 326 "/users/profs/2016/francois.trahay/soft/install/openmpi-2.0.1/include/mpi.h"
typedef ptrdiff_t MPI_Aint;
typedef long MPI_Offset;
typedef long MPI_Count;
typedef struct ompi_communicator_t *MPI_Comm;
typedef struct ompi_datatype_t *MPI_Datatype;
typedef struct ompi_errhandler_t *MPI_Errhandler;

typedef struct ompi_file_t *MPI_File;

typedef struct ompi_group_t *MPI_Group;
typedef struct ompi_info_t *MPI_Info;
typedef struct ompi_op_t *MPI_Op;
typedef struct ompi_request_t *MPI_Request;
typedef struct ompi_message_t *MPI_Message;
typedef struct ompi_status_public_t MPI_Status;
typedef struct ompi_win_t *MPI_Win;
typedef struct mca_base_var_enum_t *MPI_T_enum;
typedef struct ompi_mpit_cvar_handle_t *MPI_T_cvar_handle;
typedef struct mca_base_pvar_handle_t *MPI_T_pvar_handle;
typedef struct mca_base_pvar_session_t *MPI_T_pvar_session;




struct ompi_status_public_t {


    int MPI_SOURCE;
    int MPI_TAG;
    int MPI_ERROR;




    int _cancelled;
    size_t _ucount;
};
typedef struct ompi_status_public_t ompi_status_public_t;
# 373 "/users/profs/2016/francois.trahay/soft/install/openmpi-2.0.1/include/mpi.h"
typedef int (MPI_Copy_function)(MPI_Comm, int, void *,
                                void *, void *, int *);
typedef int (MPI_Delete_function)(MPI_Comm, int, void *, void *);
typedef int (MPI_Datarep_extent_function)(MPI_Datatype, MPI_Aint *, void *);
typedef int (MPI_Datarep_conversion_function)(void *, MPI_Datatype,
                                              int, void *, MPI_Offset, void *);
typedef void (MPI_Comm_errhandler_function)(MPI_Comm *, int *, ...);
typedef MPI_Comm_errhandler_function MPI_Comm_errhandler_fn
        __attribute__((__deprecated__));






typedef void (ompi_file_errhandler_fn)(MPI_File *, int *, ...);
typedef ompi_file_errhandler_fn MPI_File_errhandler_fn
        __attribute__((__deprecated__));
typedef ompi_file_errhandler_fn MPI_File_errhandler_function;




typedef void (MPI_Win_errhandler_function)(MPI_Win *, int *, ...);
typedef MPI_Win_errhandler_function MPI_Win_errhandler_fn
        __attribute__((__deprecated__));



typedef void (MPI_Handler_function)(MPI_Comm *, int *, ...);
typedef void (MPI_User_function)(void *, void *, int *, MPI_Datatype *);
typedef int (MPI_Comm_copy_attr_function)(MPI_Comm, int, void *,
                                            void *, void *, int *);
typedef int (MPI_Comm_delete_attr_function)(MPI_Comm, int, void *, void *);
typedef int (MPI_Type_copy_attr_function)(MPI_Datatype, int, void *,
                                            void *, void *, int *);
typedef int (MPI_Type_delete_attr_function)(MPI_Datatype, int,
                                              void *, void *);
typedef int (MPI_Win_copy_attr_function)(MPI_Win, int, void *,
                                           void *, void *, int *);
typedef int (MPI_Win_delete_attr_function)(MPI_Win, int, void *, void *);
typedef int (MPI_Grequest_query_function)(void *, MPI_Status *);
typedef int (MPI_Grequest_free_function)(void *);
typedef int (MPI_Grequest_cancel_function)(void *, int);
# 509 "/users/profs/2016/francois.trahay/soft/install/openmpi-2.0.1/include/mpi.h"
enum {

    MPI_TAG_UB,
    MPI_HOST,
    MPI_IO,
    MPI_WTIME_IS_GLOBAL,


    MPI_APPNUM,
    MPI_LASTUSEDCODE,
    MPI_UNIVERSE_SIZE,
    MPI_WIN_BASE,
    MPI_WIN_SIZE,
    MPI_WIN_DISP_UNIT,
    MPI_WIN_CREATE_FLAVOR,
    MPI_WIN_MODEL,



    IMPI_CLIENT_SIZE,
    IMPI_CLIENT_COLOR,
    IMPI_HOST_SIZE,
    IMPI_HOST_COLOR
};
# 623 "/users/profs/2016/francois.trahay/soft/install/openmpi-2.0.1/include/mpi.h"
enum {
  MPI_IDENT,
  MPI_CONGRUENT,
  MPI_SIMILAR,
  MPI_UNEQUAL
};





enum {
  MPI_THREAD_SINGLE,
  MPI_THREAD_FUNNELED,
  MPI_THREAD_SERIALIZED,
  MPI_THREAD_MULTIPLE
};






enum {
  MPI_COMBINER_NAMED,
  MPI_COMBINER_DUP,
  MPI_COMBINER_CONTIGUOUS,
  MPI_COMBINER_VECTOR,
  MPI_COMBINER_HVECTOR_INTEGER,
  MPI_COMBINER_HVECTOR,
  MPI_COMBINER_INDEXED,
  MPI_COMBINER_HINDEXED_INTEGER,
  MPI_COMBINER_HINDEXED,
  MPI_COMBINER_INDEXED_BLOCK,
  MPI_COMBINER_STRUCT_INTEGER,
  MPI_COMBINER_STRUCT,
  MPI_COMBINER_SUBARRAY,
  MPI_COMBINER_DARRAY,
  MPI_COMBINER_F90_REAL,
  MPI_COMBINER_F90_COMPLEX,
  MPI_COMBINER_F90_INTEGER,
  MPI_COMBINER_RESIZED,
  MPI_COMBINER_HINDEXED_BLOCK
};






enum {
  MPI_COMM_TYPE_SHARED,
  OMPI_COMM_TYPE_HWTHREAD,
  OMPI_COMM_TYPE_CORE,
  OMPI_COMM_TYPE_L1CACHE,
  OMPI_COMM_TYPE_L2CACHE,
  OMPI_COMM_TYPE_L3CACHE,
  OMPI_COMM_TYPE_SOCKET,
  OMPI_COMM_TYPE_NUMA,
  OMPI_COMM_TYPE_BOARD,
  OMPI_COMM_TYPE_HOST,
  OMPI_COMM_TYPE_CU,
  OMPI_COMM_TYPE_CLUSTER
};





enum {
  MPI_T_VERBOSITY_USER_BASIC,
  MPI_T_VERBOSITY_USER_DETAIL,
  MPI_T_VERBOSITY_USER_ALL,
  MPI_T_VERBOSITY_TUNER_BASIC,
  MPI_T_VERBOSITY_TUNER_DETAIL,
  MPI_T_VERBOSITY_TUNER_ALL,
  MPI_T_VERBOSITY_MPIDEV_BASIC,
  MPI_T_VERBOSITY_MPIDEV_DETAIL,
  MPI_T_VERBOSITY_MPIDEV_ALL
};




enum {
  MPI_T_SCOPE_CONSTANT,
  MPI_T_SCOPE_READONLY,
  MPI_T_SCOPE_LOCAL,
  MPI_T_SCOPE_GROUP,
  MPI_T_SCOPE_GROUP_EQ,
  MPI_T_SCOPE_ALL,
  MPI_T_SCOPE_ALL_EQ
};




enum {
  MPI_T_BIND_NO_OBJECT,
  MPI_T_BIND_MPI_COMM,
  MPI_T_BIND_MPI_DATATYPE,
  MPI_T_BIND_MPI_ERRHANDLER,
  MPI_T_BIND_MPI_FILE,
  MPI_T_BIND_MPI_GROUP,
  MPI_T_BIND_MPI_OP,
  MPI_T_BIND_MPI_REQUEST,
  MPI_T_BIND_MPI_WIN,
  MPI_T_BIND_MPI_MESSAGE,
  MPI_T_BIND_MPI_INFO
};




enum {
  MPI_T_PVAR_CLASS_STATE,
  MPI_T_PVAR_CLASS_LEVEL,
  MPI_T_PVAR_CLASS_SIZE,
  MPI_T_PVAR_CLASS_PERCENTAGE,
  MPI_T_PVAR_CLASS_HIGHWATERMARK,
  MPI_T_PVAR_CLASS_LOWWATERMARK,
  MPI_T_PVAR_CLASS_COUNTER,
  MPI_T_PVAR_CLASS_AGGREGATE,
  MPI_T_PVAR_CLASS_TIMER,
  MPI_T_PVAR_CLASS_GENERIC
};
# 824 "/users/profs/2016/francois.trahay/soft/install/openmpi-2.0.1/include/mpi.h"
__attribute__((visibility("default"))) int OMPI_C_MPI_TYPE_NULL_DELETE_FN( MPI_Datatype datatype,
                                                  int type_keyval,
                                                  void* attribute_val_out,
                                                  void* extra_state );
__attribute__((visibility("default"))) int OMPI_C_MPI_TYPE_NULL_COPY_FN( MPI_Datatype datatype,
                                                int type_keyval,
                                                void* extra_state,
                                                void* attribute_val_in,
                                                void* attribute_val_out,
                                                int* flag );
__attribute__((visibility("default"))) int OMPI_C_MPI_TYPE_DUP_FN( MPI_Datatype datatype,
                                          int type_keyval,
                                          void* extra_state,
                                          void* attribute_val_in,
                                          void* attribute_val_out,
                                          int* flag );
__attribute__((visibility("default"))) int OMPI_C_MPI_COMM_NULL_DELETE_FN( MPI_Comm comm,
                                                  int comm_keyval,
                                                  void* attribute_val_out,
                                                  void* extra_state );
__attribute__((visibility("default"))) int OMPI_C_MPI_COMM_NULL_COPY_FN( MPI_Comm comm,
                                                int comm_keyval,
                                                void* extra_state,
                                                void* attribute_val_in,
                                                void* attribute_val_out,
                                                int* flag );
__attribute__((visibility("default"))) int OMPI_C_MPI_COMM_DUP_FN( MPI_Comm comm, int comm_keyval,
                                          void* extra_state,
                                          void* attribute_val_in,
                                          void* attribute_val_out,
                                          int* flag );
__attribute__((visibility("default"))) int OMPI_C_MPI_NULL_DELETE_FN( MPI_Comm comm, int comm_keyval,
                                             void* attribute_val_out,
                                             void* extra_state )
                                             __attribute__((__deprecated__));
__attribute__((visibility("default"))) int OMPI_C_MPI_NULL_COPY_FN( MPI_Comm comm, int comm_keyval,
                                           void* extra_state,
                                           void* attribute_val_in,
                                           void* attribute_val_out,
                                           int* flag )
                                           __attribute__((__deprecated__));
__attribute__((visibility("default"))) int OMPI_C_MPI_DUP_FN( MPI_Comm comm, int comm_keyval,
                                     void* extra_state,
                                     void* attribute_val_in,
                                     void* attribute_val_out,
                                     int* flag )
                                     __attribute__((__deprecated__));
__attribute__((visibility("default"))) int OMPI_C_MPI_WIN_NULL_DELETE_FN( MPI_Win window,
                                                 int win_keyval,
                                                 void* attribute_val_out,
                                                 void* extra_state );
__attribute__((visibility("default"))) int OMPI_C_MPI_WIN_NULL_COPY_FN( MPI_Win window, int win_keyval,
                                               void* extra_state,
                                               void* attribute_val_in,
                                               void* attribute_val_out,
                                               int* flag );
__attribute__((visibility("default"))) int OMPI_C_MPI_WIN_DUP_FN( MPI_Win window, int win_keyval,
                                         void* extra_state,
                                         void* attribute_val_in,
                                         void* attribute_val_out,
                                         int* flag );
# 894 "/users/profs/2016/francois.trahay/soft/install/openmpi-2.0.1/include/mpi.h"
__attribute__((visibility("default"))) extern struct ompi_predefined_communicator_t ompi_mpi_comm_world;
__attribute__((visibility("default"))) extern struct ompi_predefined_communicator_t ompi_mpi_comm_self;
__attribute__((visibility("default"))) extern struct ompi_predefined_communicator_t ompi_mpi_comm_null;

__attribute__((visibility("default"))) extern struct ompi_predefined_group_t ompi_mpi_group_empty;
__attribute__((visibility("default"))) extern struct ompi_predefined_group_t ompi_mpi_group_null;

__attribute__((visibility("default"))) extern struct ompi_predefined_request_t ompi_request_null;

__attribute__((visibility("default"))) extern struct ompi_predefined_message_t ompi_message_null;
__attribute__((visibility("default"))) extern struct ompi_predefined_message_t ompi_message_no_proc;

__attribute__((visibility("default"))) extern struct ompi_predefined_op_t ompi_mpi_op_null;
__attribute__((visibility("default"))) extern struct ompi_predefined_op_t ompi_mpi_op_min;
__attribute__((visibility("default"))) extern struct ompi_predefined_op_t ompi_mpi_op_max;
__attribute__((visibility("default"))) extern struct ompi_predefined_op_t ompi_mpi_op_sum;
__attribute__((visibility("default"))) extern struct ompi_predefined_op_t ompi_mpi_op_prod;
__attribute__((visibility("default"))) extern struct ompi_predefined_op_t ompi_mpi_op_land;
__attribute__((visibility("default"))) extern struct ompi_predefined_op_t ompi_mpi_op_band;
__attribute__((visibility("default"))) extern struct ompi_predefined_op_t ompi_mpi_op_lor;
__attribute__((visibility("default"))) extern struct ompi_predefined_op_t ompi_mpi_op_bor;
__attribute__((visibility("default"))) extern struct ompi_predefined_op_t ompi_mpi_op_lxor;
__attribute__((visibility("default"))) extern struct ompi_predefined_op_t ompi_mpi_op_bxor;
__attribute__((visibility("default"))) extern struct ompi_predefined_op_t ompi_mpi_op_maxloc;
__attribute__((visibility("default"))) extern struct ompi_predefined_op_t ompi_mpi_op_minloc;
__attribute__((visibility("default"))) extern struct ompi_predefined_op_t ompi_mpi_op_replace;
__attribute__((visibility("default"))) extern struct ompi_predefined_op_t ompi_mpi_op_no_op;


__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_datatype_null;

__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_lb __attribute__((__deprecated__));
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_ub __attribute__((__deprecated__));
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_char;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_signed_char;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_unsigned_char;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_byte;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_short;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_unsigned_short;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_int;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_unsigned;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_long;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_unsigned_long;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_long_long_int;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_unsigned_long_long;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_float;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_double;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_long_double;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_wchar;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_packed;




__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_cxx_bool;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_cxx_cplex;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_cxx_dblcplex;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_cxx_ldblcplex;




__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_logical;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_character;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_integer;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_real;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_dblprec;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_cplex;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_dblcplex;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_ldblcplex;


__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_2int;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_2integer;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_2real;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_2dblprec;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_2cplex;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_2dblcplex;

__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_float_int;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_double_int;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_longdbl_int;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_short_int;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_long_int;


__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_logical1;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_logical2;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_logical4;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_logical8;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_integer1;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_integer2;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_integer4;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_integer8;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_integer16;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_real2;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_real4;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_real8;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_real16;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_complex8;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_complex16;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_complex32;


__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_int8_t;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_uint8_t;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_int16_t;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_uint16_t;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_int32_t;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_uint32_t;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_int64_t;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_uint64_t;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_aint;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_offset;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_count;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_c_bool;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_c_complex;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_c_float_complex;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_c_double_complex;
__attribute__((visibility("default"))) extern struct ompi_predefined_datatype_t ompi_mpi_c_long_double_complex;

__attribute__((visibility("default"))) extern struct ompi_predefined_errhandler_t ompi_mpi_errhandler_null;
__attribute__((visibility("default"))) extern struct ompi_predefined_errhandler_t ompi_mpi_errors_are_fatal;
__attribute__((visibility("default"))) extern struct ompi_predefined_errhandler_t ompi_mpi_errors_return;

__attribute__((visibility("default"))) extern struct ompi_predefined_win_t ompi_mpi_win_null;
__attribute__((visibility("default"))) extern struct ompi_predefined_file_t ompi_mpi_file_null;

__attribute__((visibility("default"))) extern struct ompi_predefined_info_t ompi_mpi_info_null;
__attribute__((visibility("default"))) extern struct ompi_predefined_info_t ompi_mpi_info_env;

__attribute__((visibility("default"))) extern int *MPI_F_STATUS_IGNORE;
__attribute__((visibility("default"))) extern int *MPI_F_STATUSES_IGNORE;
# 1193 "/users/profs/2016/francois.trahay/soft/install/openmpi-2.0.1/include/mpi.h"
__attribute__((visibility("default"))) int MPI_Abort(MPI_Comm comm, int errorcode);
__attribute__((visibility("default"))) int MPI_Accumulate(const void *origin_addr, int origin_count, MPI_Datatype origin_datatype,
                                  int target_rank, MPI_Aint target_disp, int target_count,
                                  MPI_Datatype target_datatype, MPI_Op op, MPI_Win win);
__attribute__((visibility("default"))) int MPI_Add_error_class(int *errorclass);
__attribute__((visibility("default"))) int MPI_Add_error_code(int errorclass, int *errorcode);
__attribute__((visibility("default"))) int MPI_Add_error_string(int errorcode, const char *string);
__attribute__((visibility("default"))) int MPI_Address(void *location, MPI_Aint *address)
                               __attribute__((__deprecated__));
__attribute__((visibility("default"))) int MPI_Allgather(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                 void *recvbuf, int recvcount,
                                 MPI_Datatype recvtype, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Iallgather(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                 void *recvbuf, int recvcount,
                                 MPI_Datatype recvtype, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Allgatherv(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                  void *recvbuf, const int recvcounts[],
                                  const int displs[], MPI_Datatype recvtype, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Iallgatherv(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                  void *recvbuf, const int recvcounts[],
                                  const int displs[], MPI_Datatype recvtype, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Alloc_mem(MPI_Aint size, MPI_Info info,
                                 void *baseptr);
__attribute__((visibility("default"))) int MPI_Allreduce(const void *sendbuf, void *recvbuf, int count,
                                 MPI_Datatype datatype, MPI_Op op, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Iallreduce(const void *sendbuf, void *recvbuf, int count,
                                 MPI_Datatype datatype, MPI_Op op, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Alltoall(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                void *recvbuf, int recvcount,
                                MPI_Datatype recvtype, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Ialltoall(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                void *recvbuf, int recvcount,
                                MPI_Datatype recvtype, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Alltoallv(const void *sendbuf, const int sendcounts[], const int sdispls[],
                                 MPI_Datatype sendtype, void *recvbuf, const int recvcounts[],
                                 const int rdispls[], MPI_Datatype recvtype, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Ialltoallv(const void *sendbuf, const int sendcounts[], const int sdispls[],
                                 MPI_Datatype sendtype, void *recvbuf, const int recvcounts[],
                                 const int rdispls[], MPI_Datatype recvtype, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Alltoallw(const void *sendbuf, const int sendcounts[], const int sdispls[], const MPI_Datatype sendtypes[],
                                 void *recvbuf, const int recvcounts[], const int rdispls[], const MPI_Datatype recvtypes[],
                                 MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Ialltoallw(const void *sendbuf, const int sendcounts[], const int sdispls[], const MPI_Datatype sendtypes[],
                                 void *recvbuf, const int recvcounts[], const int rdispls[], const MPI_Datatype recvtypes[],
                                 MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Attr_delete(MPI_Comm comm, int keyval)
                                   __attribute__((__deprecated__));
__attribute__((visibility("default"))) int MPI_Attr_get(MPI_Comm comm, int keyval, void *attribute_val, int *flag)
                                __attribute__((__deprecated__));
__attribute__((visibility("default"))) int MPI_Attr_put(MPI_Comm comm, int keyval, void *attribute_val)
                                __attribute__((__deprecated__));
__attribute__((visibility("default"))) int MPI_Barrier(MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Ibarrier(MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Bcast(void *buffer, int count, MPI_Datatype datatype,
                             int root, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Bsend(const void *buf, int count, MPI_Datatype datatype,
                             int dest, int tag, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Ibcast(void *buffer, int count, MPI_Datatype datatype,
                                  int root, MPI_Comm comm,
             MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Bsend_init(const void *buf, int count, MPI_Datatype datatype,
                                  int dest, int tag, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Buffer_attach(void *buffer, int size);
__attribute__((visibility("default"))) int MPI_Buffer_detach(void *buffer, int *size);
__attribute__((visibility("default"))) int MPI_Cancel(MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Cart_coords(MPI_Comm comm, int rank, int maxdims, int coords[]);
__attribute__((visibility("default"))) int MPI_Cart_create(MPI_Comm old_comm, int ndims, const int dims[],
                                   const int periods[], int reorder, MPI_Comm *comm_cart);
__attribute__((visibility("default"))) int MPI_Cart_get(MPI_Comm comm, int maxdims, int dims[],
                                int periods[], int coords[]);
__attribute__((visibility("default"))) int MPI_Cart_map(MPI_Comm comm, int ndims, const int dims[],
                                const int periods[], int *newrank);
__attribute__((visibility("default"))) int MPI_Cart_rank(MPI_Comm comm, const int coords[], int *rank);
__attribute__((visibility("default"))) int MPI_Cart_shift(MPI_Comm comm, int direction, int disp,
                                  int *rank_source, int *rank_dest);
__attribute__((visibility("default"))) int MPI_Cart_sub(MPI_Comm comm, const int remain_dims[], MPI_Comm *new_comm);
__attribute__((visibility("default"))) int MPI_Cartdim_get(MPI_Comm comm, int *ndims);
__attribute__((visibility("default"))) int MPI_Close_port(const char *port_name);
__attribute__((visibility("default"))) int MPI_Comm_accept(const char *port_name, MPI_Info info, int root,
                                   MPI_Comm comm, MPI_Comm *newcomm);
__attribute__((visibility("default"))) int MPI_Comm_c2f(MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Comm_call_errhandler(MPI_Comm comm, int errorcode);
__attribute__((visibility("default"))) int MPI_Comm_compare(MPI_Comm comm1, MPI_Comm comm2, int *result);
__attribute__((visibility("default"))) int MPI_Comm_connect(const char *port_name, MPI_Info info, int root,
                                    MPI_Comm comm, MPI_Comm *newcomm);
__attribute__((visibility("default"))) int MPI_Comm_create_errhandler(MPI_Comm_errhandler_function *function,
                                              MPI_Errhandler *errhandler);
__attribute__((visibility("default"))) int MPI_Comm_create_keyval(MPI_Comm_copy_attr_function *comm_copy_attr_fn,
                                          MPI_Comm_delete_attr_function *comm_delete_attr_fn,
                                          int *comm_keyval, void *extra_state);
__attribute__((visibility("default"))) int MPI_Comm_create_group(MPI_Comm comm, MPI_Group group, int tag, MPI_Comm *newcomm);
__attribute__((visibility("default"))) int MPI_Comm_create(MPI_Comm comm, MPI_Group group, MPI_Comm *newcomm);
__attribute__((visibility("default"))) int MPI_Comm_delete_attr(MPI_Comm comm, int comm_keyval);
__attribute__((visibility("default"))) int MPI_Comm_disconnect(MPI_Comm *comm);
__attribute__((visibility("default"))) int MPI_Comm_dup(MPI_Comm comm, MPI_Comm *newcomm);
__attribute__((visibility("default"))) int MPI_Comm_idup(MPI_Comm comm, MPI_Comm *newcomm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Comm_dup_with_info(MPI_Comm comm, MPI_Info info, MPI_Comm *newcomm);
__attribute__((visibility("default"))) MPI_Comm MPI_Comm_f2c(int comm);
__attribute__((visibility("default"))) int MPI_Comm_free_keyval(int *comm_keyval);
__attribute__((visibility("default"))) int MPI_Comm_free(MPI_Comm *comm);
__attribute__((visibility("default"))) int MPI_Comm_get_attr(MPI_Comm comm, int comm_keyval,
                                     void *attribute_val, int *flag);
__attribute__((visibility("default"))) int MPI_Dist_graph_create(MPI_Comm comm_old, int n, const int nodes[],
                                         const int degrees[], const int targets[],
                                         const int weights[], MPI_Info info,
                                         int reorder, MPI_Comm * newcomm);
__attribute__((visibility("default"))) int MPI_Dist_graph_create_adjacent(MPI_Comm comm_old,
                                                  int indegree, const int sources[],
                                                  const int sourceweights[],
                                                  int outdegree,
                                                  const int destinations[],
                                                  const int destweights[],
                                                  MPI_Info info, int reorder,
                                                  MPI_Comm *comm_dist_graph);
__attribute__((visibility("default"))) int MPI_Dist_graph_neighbors(MPI_Comm comm, int maxindegree,
                                           int sources[], int sourceweights[],
                                           int maxoutdegree,
                                           int destinations[],
                                           int destweights[]);
__attribute__((visibility("default"))) int MPI_Dist_graph_neighbors_count(MPI_Comm comm,
                                                  int *inneighbors,
                                                  int *outneighbors,
                                                  int *weighted);
__attribute__((visibility("default"))) int MPI_Comm_get_errhandler(MPI_Comm comm, MPI_Errhandler *erhandler);
__attribute__((visibility("default"))) int MPI_Comm_get_info(MPI_Comm comm, MPI_Info *info_used);
__attribute__((visibility("default"))) int MPI_Comm_get_name(MPI_Comm comm, char *comm_name, int *resultlen);
__attribute__((visibility("default"))) int MPI_Comm_get_parent(MPI_Comm *parent);
__attribute__((visibility("default"))) int MPI_Comm_group(MPI_Comm comm, MPI_Group *group);
__attribute__((visibility("default"))) int MPI_Comm_join(int fd, MPI_Comm *intercomm);
__attribute__((visibility("default"))) int MPI_Comm_rank(MPI_Comm comm, int *rank);
__attribute__((visibility("default"))) int MPI_Comm_remote_group(MPI_Comm comm, MPI_Group *group);
__attribute__((visibility("default"))) int MPI_Comm_remote_size(MPI_Comm comm, int *size);
__attribute__((visibility("default"))) int MPI_Comm_set_attr(MPI_Comm comm, int comm_keyval, void *attribute_val);
__attribute__((visibility("default"))) int MPI_Comm_set_errhandler(MPI_Comm comm, MPI_Errhandler errhandler);
__attribute__((visibility("default"))) int MPI_Comm_set_info(MPI_Comm comm, MPI_Info info);
__attribute__((visibility("default"))) int MPI_Comm_set_name(MPI_Comm comm, const char *comm_name);
__attribute__((visibility("default"))) int MPI_Comm_size(MPI_Comm comm, int *size);
__attribute__((visibility("default"))) int MPI_Comm_spawn(const char *command, char *argv[], int maxprocs, MPI_Info info,
                                  int root, MPI_Comm comm, MPI_Comm *intercomm,
                                  int array_of_errcodes[]);
__attribute__((visibility("default"))) int MPI_Comm_spawn_multiple(int count, char *array_of_commands[], char **array_of_argv[],
                                           const int array_of_maxprocs[], const MPI_Info array_of_info[],
                                           int root, MPI_Comm comm, MPI_Comm *intercomm,
                                           int array_of_errcodes[]);
__attribute__((visibility("default"))) int MPI_Comm_split(MPI_Comm comm, int color, int key, MPI_Comm *newcomm);
__attribute__((visibility("default"))) int MPI_Comm_split_type(MPI_Comm comm, int split_type, int key, MPI_Info info, MPI_Comm *newcomm);
__attribute__((visibility("default"))) int MPI_Comm_test_inter(MPI_Comm comm, int *flag);
__attribute__((visibility("default"))) int MPI_Compare_and_swap(const void *origin_addr, const void *compare_addr,
                                        void *result_addr, MPI_Datatype datatype, int target_rank,
                                        MPI_Aint target_disp, MPI_Win win);
__attribute__((visibility("default"))) int MPI_Dims_create(int nnodes, int ndims, int dims[]);
__attribute__((visibility("default"))) int MPI_Errhandler_c2f(MPI_Errhandler errhandler);
__attribute__((visibility("default"))) int MPI_Errhandler_create(MPI_Handler_function *function,
                                         MPI_Errhandler *errhandler)
                                         __attribute__((__deprecated__));
__attribute__((visibility("default"))) MPI_Errhandler MPI_Errhandler_f2c(int errhandler);
__attribute__((visibility("default"))) int MPI_Errhandler_free(MPI_Errhandler *errhandler);
__attribute__((visibility("default"))) int MPI_Errhandler_get(MPI_Comm comm, MPI_Errhandler *errhandler)
                                      __attribute__((__deprecated__));
__attribute__((visibility("default"))) int MPI_Errhandler_set(MPI_Comm comm, MPI_Errhandler errhandler)
                                      __attribute__((__deprecated__));
__attribute__((visibility("default"))) int MPI_Error_class(int errorcode, int *errorclass);
__attribute__((visibility("default"))) int MPI_Error_string(int errorcode, char *string, int *resultlen);
__attribute__((visibility("default"))) int MPI_Exscan(const void *sendbuf, void *recvbuf, int count,
                              MPI_Datatype datatype, MPI_Op op, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Fetch_and_op(const void *origin_addr, void *result_addr, MPI_Datatype datatype,
                                    int target_rank, MPI_Aint target_disp, MPI_Op op, MPI_Win win);
__attribute__((visibility("default"))) int MPI_Iexscan(const void *sendbuf, void *recvbuf, int count,
                              MPI_Datatype datatype, MPI_Op op, MPI_Comm comm, MPI_Request *request);

__attribute__((visibility("default"))) int MPI_File_c2f(MPI_File file);
__attribute__((visibility("default"))) MPI_File MPI_File_f2c(int file);
__attribute__((visibility("default"))) int MPI_File_call_errhandler(MPI_File fh, int errorcode);
__attribute__((visibility("default"))) int MPI_File_create_errhandler(MPI_File_errhandler_function *function,
                                              MPI_Errhandler *errhandler);
__attribute__((visibility("default"))) int MPI_File_set_errhandler( MPI_File file, MPI_Errhandler errhandler);
__attribute__((visibility("default"))) int MPI_File_get_errhandler( MPI_File file, MPI_Errhandler *errhandler);
__attribute__((visibility("default"))) int MPI_File_open(MPI_Comm comm, const char *filename, int amode,
                                 MPI_Info info, MPI_File *fh);
__attribute__((visibility("default"))) int MPI_File_close(MPI_File *fh);
__attribute__((visibility("default"))) int MPI_File_delete(const char *filename, MPI_Info info);
__attribute__((visibility("default"))) int MPI_File_set_size(MPI_File fh, MPI_Offset size);
__attribute__((visibility("default"))) int MPI_File_preallocate(MPI_File fh, MPI_Offset size);
__attribute__((visibility("default"))) int MPI_File_get_size(MPI_File fh, MPI_Offset *size);
__attribute__((visibility("default"))) int MPI_File_get_group(MPI_File fh, MPI_Group *group);
__attribute__((visibility("default"))) int MPI_File_get_amode(MPI_File fh, int *amode);
__attribute__((visibility("default"))) int MPI_File_set_info(MPI_File fh, MPI_Info info);
__attribute__((visibility("default"))) int MPI_File_get_info(MPI_File fh, MPI_Info *info_used);
__attribute__((visibility("default"))) int MPI_File_set_view(MPI_File fh, MPI_Offset disp, MPI_Datatype etype,
                                     MPI_Datatype filetype, const char *datarep, MPI_Info info);
__attribute__((visibility("default"))) int MPI_File_get_view(MPI_File fh, MPI_Offset *disp,
                                     MPI_Datatype *etype,
                                     MPI_Datatype *filetype, char *datarep);
__attribute__((visibility("default"))) int MPI_File_read_at(MPI_File fh, MPI_Offset offset, void *buf,
                                    int count, MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_File_read_at_all(MPI_File fh, MPI_Offset offset, void *buf,
                                        int count, MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_File_write_at(MPI_File fh, MPI_Offset offset, const void *buf,
                                     int count, MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_File_write_at_all(MPI_File fh, MPI_Offset offset, const void *buf,
                                         int count, MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_File_iread_at(MPI_File fh, MPI_Offset offset, void *buf,
                                     int count, MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_File_iwrite_at(MPI_File fh, MPI_Offset offset, const void *buf,
                                      int count, MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_File_iread_at_all(MPI_File fh, MPI_Offset offset, void *buf,
                                     int count, MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_File_iwrite_at_all(MPI_File fh, MPI_Offset offset, const void *buf,
                                      int count, MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_File_read(MPI_File fh, void *buf, int count,
                                 MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_File_read_all(MPI_File fh, void *buf, int count,
                                     MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_File_write(MPI_File fh, const void *buf, int count,
                                  MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_File_write_all(MPI_File fh, const void *buf, int count,
                                      MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_File_iread(MPI_File fh, void *buf, int count,
                                  MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_File_iwrite(MPI_File fh, const void *buf, int count,
                                   MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_File_iread_all(MPI_File fh, void *buf, int count,
                                  MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_File_iwrite_all(MPI_File fh, const void *buf, int count,
                                   MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_File_seek(MPI_File fh, MPI_Offset offset, int whence);
__attribute__((visibility("default"))) int MPI_File_get_position(MPI_File fh, MPI_Offset *offset);
__attribute__((visibility("default"))) int MPI_File_get_byte_offset(MPI_File fh, MPI_Offset offset,
                                            MPI_Offset *disp);
__attribute__((visibility("default"))) int MPI_File_read_shared(MPI_File fh, void *buf, int count,
                                        MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_File_write_shared(MPI_File fh, const void *buf, int count,
      MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_File_iread_shared(MPI_File fh, void *buf, int count,
                                         MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_File_iwrite_shared(MPI_File fh, const void *buf, int count,
                                          MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_File_read_ordered(MPI_File fh, void *buf, int count,
                                         MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_File_write_ordered(MPI_File fh, const void *buf, int count,
                                          MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_File_seek_shared(MPI_File fh, MPI_Offset offset, int whence);
__attribute__((visibility("default"))) int MPI_File_get_position_shared(MPI_File fh, MPI_Offset *offset);
__attribute__((visibility("default"))) int MPI_File_read_at_all_begin(MPI_File fh, MPI_Offset offset, void *buf,
                                              int count, MPI_Datatype datatype);
__attribute__((visibility("default"))) int MPI_File_read_at_all_end(MPI_File fh, void *buf, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_File_write_at_all_begin(MPI_File fh, MPI_Offset offset, const void *buf,
                                               int count, MPI_Datatype datatype);
__attribute__((visibility("default"))) int MPI_File_write_at_all_end(MPI_File fh, const void *buf, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_File_read_all_begin(MPI_File fh, void *buf, int count,
                                           MPI_Datatype datatype);
__attribute__((visibility("default"))) int MPI_File_read_all_end(MPI_File fh, void *buf, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_File_write_all_begin(MPI_File fh, const void *buf, int count,
                                            MPI_Datatype datatype);
__attribute__((visibility("default"))) int MPI_File_write_all_end(MPI_File fh, const void *buf, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_File_read_ordered_begin(MPI_File fh, void *buf, int count,
                                               MPI_Datatype datatype);
__attribute__((visibility("default"))) int MPI_File_read_ordered_end(MPI_File fh, void *buf, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_File_write_ordered_begin(MPI_File fh, const void *buf, int count,
                                                MPI_Datatype datatype);
__attribute__((visibility("default"))) int MPI_File_write_ordered_end(MPI_File fh, const void *buf, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_File_get_type_extent(MPI_File fh, MPI_Datatype datatype,
                                            MPI_Aint *extent);
__attribute__((visibility("default"))) int MPI_File_set_atomicity(MPI_File fh, int flag);
__attribute__((visibility("default"))) int MPI_File_get_atomicity(MPI_File fh, int *flag);
__attribute__((visibility("default"))) int MPI_File_sync(MPI_File fh);

__attribute__((visibility("default"))) int MPI_Finalize(void);
__attribute__((visibility("default"))) int MPI_Finalized(int *flag);
__attribute__((visibility("default"))) int MPI_Free_mem(void *base);
__attribute__((visibility("default"))) int MPI_Gather(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                              void *recvbuf, int recvcount, MPI_Datatype recvtype,
                              int root, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Igather(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                              void *recvbuf, int recvcount, MPI_Datatype recvtype,
                              int root, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Gatherv(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                               void *recvbuf, const int recvcounts[], const int displs[],
                               MPI_Datatype recvtype, int root, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Igatherv(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                               void *recvbuf, const int recvcounts[], const int displs[],
                               MPI_Datatype recvtype, int root, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Get_address(const void *location, MPI_Aint *address);
__attribute__((visibility("default"))) int MPI_Get_count(const MPI_Status *status, MPI_Datatype datatype, int *count);
__attribute__((visibility("default"))) int MPI_Get_elements(const MPI_Status *status, MPI_Datatype datatype, int *count);
__attribute__((visibility("default"))) int MPI_Get_elements_x(const MPI_Status *status, MPI_Datatype datatype, MPI_Count *count);
__attribute__((visibility("default"))) int MPI_Get(void *origin_addr, int origin_count,
                           MPI_Datatype origin_datatype, int target_rank,
                           MPI_Aint target_disp, int target_count,
                           MPI_Datatype target_datatype, MPI_Win win);
__attribute__((visibility("default"))) int MPI_Get_accumulate(const void *origin_addr, int origin_count, MPI_Datatype origin_datatype,
                                      void *result_addr, int result_count, MPI_Datatype result_datatype,
                                      int target_rank, MPI_Aint target_disp, int target_count,
                                      MPI_Datatype target_datatype, MPI_Op op, MPI_Win win);
__attribute__((visibility("default"))) int MPI_Get_library_version(char *version, int *resultlen);
__attribute__((visibility("default"))) int MPI_Get_processor_name(char *name, int *resultlen);
__attribute__((visibility("default"))) int MPI_Get_version(int *version, int *subversion);
__attribute__((visibility("default"))) int MPI_Graph_create(MPI_Comm comm_old, int nnodes, const int index[],
                                    const int edges[], int reorder, MPI_Comm *comm_graph);
__attribute__((visibility("default"))) int MPI_Graph_get(MPI_Comm comm, int maxindex, int maxedges,
                                 int index[], int edges[]);
__attribute__((visibility("default"))) int MPI_Graph_map(MPI_Comm comm, int nnodes, const int index[], const int edges[],
                                 int *newrank);
__attribute__((visibility("default"))) int MPI_Graph_neighbors_count(MPI_Comm comm, int rank, int *nneighbors);
__attribute__((visibility("default"))) int MPI_Graph_neighbors(MPI_Comm comm, int rank, int maxneighbors,
                                       int neighbors[]);
__attribute__((visibility("default"))) int MPI_Graphdims_get(MPI_Comm comm, int *nnodes, int *nedges);
__attribute__((visibility("default"))) int MPI_Grequest_complete(MPI_Request request);
__attribute__((visibility("default"))) int MPI_Grequest_start(MPI_Grequest_query_function *query_fn,
                                      MPI_Grequest_free_function *free_fn,
                                      MPI_Grequest_cancel_function *cancel_fn,
                                      void *extra_state, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Group_c2f(MPI_Group group);
__attribute__((visibility("default"))) int MPI_Group_compare(MPI_Group group1, MPI_Group group2, int *result);
__attribute__((visibility("default"))) int MPI_Group_difference(MPI_Group group1, MPI_Group group2,
                                        MPI_Group *newgroup);
__attribute__((visibility("default"))) int MPI_Group_excl(MPI_Group group, int n, const int ranks[],
                                  MPI_Group *newgroup);
__attribute__((visibility("default"))) MPI_Group MPI_Group_f2c(int group);
__attribute__((visibility("default"))) int MPI_Group_free(MPI_Group *group);
__attribute__((visibility("default"))) int MPI_Group_incl(MPI_Group group, int n, const int ranks[],
                                  MPI_Group *newgroup);
__attribute__((visibility("default"))) int MPI_Group_intersection(MPI_Group group1, MPI_Group group2,
                                          MPI_Group *newgroup);
__attribute__((visibility("default"))) int MPI_Group_range_excl(MPI_Group group, int n, int ranges[][3],
                                        MPI_Group *newgroup);
__attribute__((visibility("default"))) int MPI_Group_range_incl(MPI_Group group, int n, int ranges[][3],
                                        MPI_Group *newgroup);
__attribute__((visibility("default"))) int MPI_Group_rank(MPI_Group group, int *rank);
__attribute__((visibility("default"))) int MPI_Group_size(MPI_Group group, int *size);
__attribute__((visibility("default"))) int MPI_Group_translate_ranks(MPI_Group group1, int n, const int ranks1[],
                                             MPI_Group group2, int ranks2[]);
__attribute__((visibility("default"))) int MPI_Group_union(MPI_Group group1, MPI_Group group2,
                                   MPI_Group *newgroup);
__attribute__((visibility("default"))) int MPI_Ibsend(const void *buf, int count, MPI_Datatype datatype, int dest,
                              int tag, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Improbe(int source, int tag, MPI_Comm comm,
                               int *flag, MPI_Message *message,
                               MPI_Status *status);
__attribute__((visibility("default"))) int MPI_Imrecv(void *buf, int count, MPI_Datatype type,
                              MPI_Message *message, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Info_c2f(MPI_Info info);
__attribute__((visibility("default"))) int MPI_Info_create(MPI_Info *info);
__attribute__((visibility("default"))) int MPI_Info_delete(MPI_Info info, const char *key);
__attribute__((visibility("default"))) int MPI_Info_dup(MPI_Info info, MPI_Info *newinfo);
__attribute__((visibility("default"))) MPI_Info MPI_Info_f2c(int info);
__attribute__((visibility("default"))) int MPI_Info_free(MPI_Info *info);
__attribute__((visibility("default"))) int MPI_Info_get(MPI_Info info, const char *key, int valuelen,
                                char *value, int *flag);
__attribute__((visibility("default"))) int MPI_Info_get_nkeys(MPI_Info info, int *nkeys);
__attribute__((visibility("default"))) int MPI_Info_get_nthkey(MPI_Info info, int n, char *key);
__attribute__((visibility("default"))) int MPI_Info_get_valuelen(MPI_Info info, const char *key, int *valuelen,
                                         int *flag);
__attribute__((visibility("default"))) int MPI_Info_set(MPI_Info info, const char *key, const char *value);
__attribute__((visibility("default"))) int MPI_Init(int *argc, char ***argv);
__attribute__((visibility("default"))) int MPI_Initialized(int *flag);
__attribute__((visibility("default"))) int MPI_Init_thread(int *argc, char ***argv, int required,
                                   int *provided);
__attribute__((visibility("default"))) int MPI_Intercomm_create(MPI_Comm local_comm, int local_leader,
                                        MPI_Comm bridge_comm, int remote_leader,
                                        int tag, MPI_Comm *newintercomm);
__attribute__((visibility("default"))) int MPI_Intercomm_merge(MPI_Comm intercomm, int high,
                                       MPI_Comm *newintercomm);
__attribute__((visibility("default"))) int MPI_Iprobe(int source, int tag, MPI_Comm comm, int *flag,
                              MPI_Status *status);
__attribute__((visibility("default"))) int MPI_Irecv(void *buf, int count, MPI_Datatype datatype, int source,
                             int tag, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Irsend(const void *buf, int count, MPI_Datatype datatype, int dest,
                              int tag, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Isend(const void *buf, int count, MPI_Datatype datatype, int dest,
                             int tag, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Issend(const void *buf, int count, MPI_Datatype datatype, int dest,
                              int tag, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Is_thread_main(int *flag);
__attribute__((visibility("default"))) int MPI_Keyval_create(MPI_Copy_function *copy_fn,
                                     MPI_Delete_function *delete_fn,
                                     int *keyval, void *extra_state)
                                     __attribute__((__deprecated__));
__attribute__((visibility("default"))) int MPI_Keyval_free(int *keyval)
                                   __attribute__((__deprecated__));
__attribute__((visibility("default"))) int MPI_Lookup_name(const char *service_name, MPI_Info info, char *port_name);
__attribute__((visibility("default"))) int MPI_Message_c2f(MPI_Message message);
__attribute__((visibility("default"))) MPI_Message MPI_Message_f2c(int message);
__attribute__((visibility("default"))) int MPI_Mprobe(int source, int tag, MPI_Comm comm,
                               MPI_Message *message,
                               MPI_Status *status);
__attribute__((visibility("default"))) int MPI_Mrecv(void *buf, int count, MPI_Datatype type,
                             MPI_Message *message, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_Neighbor_allgather(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                          void *recvbuf, int recvcount, MPI_Datatype recvtype,
                                          MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Ineighbor_allgather(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                           void *recvbuf, int recvcount, MPI_Datatype recvtype,
                                           MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Neighbor_allgatherv(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                           void *recvbuf, const int recvcounts[], const int displs[],
                                           MPI_Datatype recvtype, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Ineighbor_allgatherv(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                            void *recvbuf, const int recvcounts[], const int displs[],
                                            MPI_Datatype recvtype, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Neighbor_alltoall(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                         void *recvbuf, int recvcount, MPI_Datatype recvtype,
                                         MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Ineighbor_alltoall(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                          void *recvbuf, int recvcount, MPI_Datatype recvtype,
                                          MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Neighbor_alltoallv(const void *sendbuf, const int sendcounts[], const int sdispls[], MPI_Datatype sendtype,
                                          void *recvbuf, const int recvcounts[], const int rdispls[], MPI_Datatype recvtype,
                                          MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Ineighbor_alltoallv(const void *sendbuf, const int sendcounts[], const int sdispls[], MPI_Datatype sendtype,
                                           void *recvbuf, const int recvcounts[], const int rdispls[], MPI_Datatype recvtype,
                                           MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Neighbor_alltoallw(const void *sendbuf, const int sendcounts[], const MPI_Aint sdispls[], const MPI_Datatype sendtypes[],
                                          void *recvbuf, const int recvcounts[], const MPI_Aint rdispls[], const MPI_Datatype recvtypes[],
                                          MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Ineighbor_alltoallw(const void *sendbuf, const int sendcounts[], const MPI_Aint sdispls[], const MPI_Datatype sendtypes[],
                                           void *recvbuf, const int recvcounts[], const MPI_Aint rdispls[], const MPI_Datatype recvtypes[],
                                           MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Op_c2f(MPI_Op op);
__attribute__((visibility("default"))) int MPI_Op_commutative(MPI_Op op, int *commute);
__attribute__((visibility("default"))) int MPI_Op_create(MPI_User_function *function, int commute, MPI_Op *op);
__attribute__((visibility("default"))) int MPI_Open_port(MPI_Info info, char *port_name);
__attribute__((visibility("default"))) MPI_Op MPI_Op_f2c(int op);
__attribute__((visibility("default"))) int MPI_Op_free(MPI_Op *op);
__attribute__((visibility("default"))) int MPI_Pack_external(const char datarep[], const void *inbuf, int incount,
                                     MPI_Datatype datatype, void *outbuf,
                                     MPI_Aint outsize, MPI_Aint *position);
__attribute__((visibility("default"))) int MPI_Pack_external_size(const char datarep[], int incount,
                                          MPI_Datatype datatype, MPI_Aint *size);
__attribute__((visibility("default"))) int MPI_Pack(const void *inbuf, int incount, MPI_Datatype datatype,
                            void *outbuf, int outsize, int *position, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Pack_size(int incount, MPI_Datatype datatype, MPI_Comm comm,
                                 int *size);
__attribute__((visibility("default"))) int MPI_Pcontrol(const int level, ...);
__attribute__((visibility("default"))) int MPI_Probe(int source, int tag, MPI_Comm comm, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_Publish_name(const char *service_name, MPI_Info info,
                                    const char *port_name);
__attribute__((visibility("default"))) int MPI_Put(const void *origin_addr, int origin_count, MPI_Datatype origin_datatype,
                           int target_rank, MPI_Aint target_disp, int target_count,
                           MPI_Datatype target_datatype, MPI_Win win);
__attribute__((visibility("default"))) int MPI_Query_thread(int *provided);
__attribute__((visibility("default"))) int MPI_Raccumulate(const void *origin_addr, int origin_count, MPI_Datatype origin_datatype,
                                   int target_rank, MPI_Aint target_disp, int target_count,
                                   MPI_Datatype target_datatype, MPI_Op op, MPI_Win win, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Recv_init(void *buf, int count, MPI_Datatype datatype, int source,
                                 int tag, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Recv(void *buf, int count, MPI_Datatype datatype, int source,
                            int tag, MPI_Comm comm, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_Reduce(const void *sendbuf, void *recvbuf, int count,
                              MPI_Datatype datatype, MPI_Op op, int root, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Ireduce(const void *sendbuf, void *recvbuf, int count,
                              MPI_Datatype datatype, MPI_Op op, int root, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Reduce_local(const void *inbuf, void *inoutbuf, int count,
                                    MPI_Datatype datatype, MPI_Op op);
__attribute__((visibility("default"))) int MPI_Reduce_scatter(const void *sendbuf, void *recvbuf, const int recvcounts[],
                                      MPI_Datatype datatype, MPI_Op op, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Ireduce_scatter(const void *sendbuf, void *recvbuf, const int recvcounts[],
                                      MPI_Datatype datatype, MPI_Op op, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Reduce_scatter_block(const void *sendbuf, void *recvbuf, int recvcount,
                                      MPI_Datatype datatype, MPI_Op op, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Ireduce_scatter_block(const void *sendbuf, void *recvbuf, int recvcount,
                                      MPI_Datatype datatype, MPI_Op op, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Register_datarep(const char *datarep,
                                        MPI_Datarep_conversion_function *read_conversion_fn,
                                        MPI_Datarep_conversion_function *write_conversion_fn,
                                        MPI_Datarep_extent_function *dtype_file_extent_fn,
                                        void *extra_state);
__attribute__((visibility("default"))) int MPI_Request_c2f(MPI_Request request);
__attribute__((visibility("default"))) MPI_Request MPI_Request_f2c(int request);
__attribute__((visibility("default"))) int MPI_Request_free(MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Request_get_status(MPI_Request request, int *flag,
                                          MPI_Status *status);
__attribute__((visibility("default"))) int MPI_Rget(void *origin_addr, int origin_count, MPI_Datatype origin_datatype,
                            int target_rank, MPI_Aint target_disp, int target_count, MPI_Datatype target_datatype,
                            MPI_Win win, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Rget_accumulate(const void *origin_addr, int origin_count, MPI_Datatype origin_datatype,
                                       void *result_addr, int result_count, MPI_Datatype result_datatype,
                                       int target_rank, MPI_Aint target_disp, int target_count,
                                       MPI_Datatype target_datatype, MPI_Op op,
                                       MPI_Win win, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Rput(const void *origin_addr, int origin_count, MPI_Datatype origin_datatype,
                            int target_rank, MPI_Aint target_disp, int target_cout,
                            MPI_Datatype target_datatype, MPI_Win win, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Rsend(const void *ibuf, int count, MPI_Datatype datatype, int dest,
                             int tag, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Rsend_init(const void *buf, int count, MPI_Datatype datatype,
                                  int dest, int tag, MPI_Comm comm,
                                  MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Scan(const void *sendbuf, void *recvbuf, int count,
                            MPI_Datatype datatype, MPI_Op op, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Iscan(const void *sendbuf, void *recvbuf, int count,
                            MPI_Datatype datatype, MPI_Op op, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Scatter(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                               void *recvbuf, int recvcount, MPI_Datatype recvtype,
                               int root, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Iscatter(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                               void *recvbuf, int recvcount, MPI_Datatype recvtype,
                               int root, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Scatterv(const void *sendbuf, const int sendcounts[], const int displs[],
                                MPI_Datatype sendtype, void *recvbuf, int recvcount,
                                MPI_Datatype recvtype, int root, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Iscatterv(const void *sendbuf, const int sendcounts[], const int displs[],
                                MPI_Datatype sendtype, void *recvbuf, int recvcount,
                                MPI_Datatype recvtype, int root, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Send_init(const void *buf, int count, MPI_Datatype datatype,
                                 int dest, int tag, MPI_Comm comm,
                                 MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Send(const void *buf, int count, MPI_Datatype datatype, int dest,
                            int tag, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Sendrecv(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                int dest, int sendtag, void *recvbuf, int recvcount,
                                MPI_Datatype recvtype, int source, int recvtag,
                                MPI_Comm comm, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_Sendrecv_replace(void * buf, int count, MPI_Datatype datatype,
                                        int dest, int sendtag, int source, int recvtag,
                                        MPI_Comm comm, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_Ssend_init(const void *buf, int count, MPI_Datatype datatype,
                                  int dest, int tag, MPI_Comm comm,
                                  MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Ssend(const void *buf, int count, MPI_Datatype datatype, int dest,
                             int tag, MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Start(MPI_Request *request);
__attribute__((visibility("default"))) int MPI_Startall(int count, MPI_Request array_of_requests[]);
__attribute__((visibility("default"))) int MPI_Status_c2f(const MPI_Status *c_status, int *f_status);
__attribute__((visibility("default"))) int MPI_Status_f2c(const int *f_status, MPI_Status *c_status);
__attribute__((visibility("default"))) int MPI_Status_set_cancelled(MPI_Status *status, int flag);
__attribute__((visibility("default"))) int MPI_Status_set_elements(MPI_Status *status, MPI_Datatype datatype,
                                           int count);
__attribute__((visibility("default"))) int MPI_Status_set_elements_x(MPI_Status *status, MPI_Datatype datatype,
                                             MPI_Count count);
__attribute__((visibility("default"))) int MPI_Testall(int count, MPI_Request array_of_requests[], int *flag,
                               MPI_Status array_of_statuses[]);
__attribute__((visibility("default"))) int MPI_Testany(int count, MPI_Request array_of_requests[], int *index,
                               int *flag, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_Test(MPI_Request *request, int *flag, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_Test_cancelled(const MPI_Status *status, int *flag);
__attribute__((visibility("default"))) int MPI_Testsome(int incount, MPI_Request array_of_requests[],
                                int *outcount, int array_of_indices[],
                                MPI_Status array_of_statuses[]);
__attribute__((visibility("default"))) int MPI_Topo_test(MPI_Comm comm, int *status);
__attribute__((visibility("default"))) int MPI_Type_c2f(MPI_Datatype datatype);
__attribute__((visibility("default"))) int MPI_Type_commit(MPI_Datatype *type);
__attribute__((visibility("default"))) int MPI_Type_contiguous(int count, MPI_Datatype oldtype,
                                       MPI_Datatype *newtype);
__attribute__((visibility("default"))) int MPI_Type_create_darray(int size, int rank, int ndims,
                                          const int gsize_array[], const int distrib_array[],
                                          const int darg_array[], const int psize_array[],
                                          int order, MPI_Datatype oldtype,
                                          MPI_Datatype *newtype);
__attribute__((visibility("default"))) int MPI_Type_create_f90_complex(int p, int r, MPI_Datatype *newtype);
__attribute__((visibility("default"))) int MPI_Type_create_f90_integer(int r, MPI_Datatype *newtype);
__attribute__((visibility("default"))) int MPI_Type_create_f90_real(int p, int r, MPI_Datatype *newtype);
__attribute__((visibility("default"))) int MPI_Type_create_hindexed_block(int count, int blocklength,
                                                  const MPI_Aint array_of_displacements[],
                                                  MPI_Datatype oldtype,
                                                  MPI_Datatype *newtype);
__attribute__((visibility("default"))) int MPI_Type_create_hindexed(int count, const int array_of_blocklengths[],
                                            const MPI_Aint array_of_displacements[],
                                            MPI_Datatype oldtype,
                                            MPI_Datatype *newtype);
__attribute__((visibility("default"))) int MPI_Type_create_hvector(int count, int blocklength, MPI_Aint stride,
                                           MPI_Datatype oldtype,
                                           MPI_Datatype *newtype);
__attribute__((visibility("default"))) int MPI_Type_create_keyval(MPI_Type_copy_attr_function *type_copy_attr_fn,
                                          MPI_Type_delete_attr_function *type_delete_attr_fn,
                                          int *type_keyval, void *extra_state);
__attribute__((visibility("default"))) int MPI_Type_create_indexed_block(int count, int blocklength,
                                                 const int array_of_displacements[],
                                                 MPI_Datatype oldtype,
                                                 MPI_Datatype *newtype);
__attribute__((visibility("default"))) int MPI_Type_create_struct(int count, const int array_of_block_lengths[],
                                          const MPI_Aint array_of_displacements[],
                                          const MPI_Datatype array_of_types[],
                                          MPI_Datatype *newtype);
__attribute__((visibility("default"))) int MPI_Type_create_subarray(int ndims, const int size_array[], const int subsize_array[],
                                            const int start_array[], int order,
                                            MPI_Datatype oldtype, MPI_Datatype *newtype);
__attribute__((visibility("default"))) int MPI_Type_create_resized(MPI_Datatype oldtype, MPI_Aint lb,
                                           MPI_Aint extent, MPI_Datatype *newtype);
__attribute__((visibility("default"))) int MPI_Type_delete_attr(MPI_Datatype type, int type_keyval);
__attribute__((visibility("default"))) int MPI_Type_dup(MPI_Datatype type, MPI_Datatype *newtype);
__attribute__((visibility("default"))) int MPI_Type_extent(MPI_Datatype type, MPI_Aint *extent)
                                   __attribute__((__deprecated__));
__attribute__((visibility("default"))) int MPI_Type_free(MPI_Datatype *type);
__attribute__((visibility("default"))) int MPI_Type_free_keyval(int *type_keyval);
__attribute__((visibility("default"))) MPI_Datatype MPI_Type_f2c(int datatype);
__attribute__((visibility("default"))) int MPI_Type_get_attr(MPI_Datatype type, int type_keyval,
                                     void *attribute_val, int *flag);
__attribute__((visibility("default"))) int MPI_Type_get_contents(MPI_Datatype mtype, int max_integers,
                                         int max_addresses, int max_datatypes,
                                         int array_of_integers[],
                                         MPI_Aint array_of_addresses[],
                                         MPI_Datatype array_of_datatypes[]);
__attribute__((visibility("default"))) int MPI_Type_get_envelope(MPI_Datatype type, int *num_integers,
                                         int *num_addresses, int *num_datatypes,
                                         int *combiner);
__attribute__((visibility("default"))) int MPI_Type_get_extent(MPI_Datatype type, MPI_Aint *lb,
                                       MPI_Aint *extent);
__attribute__((visibility("default"))) int MPI_Type_get_extent_x(MPI_Datatype type, MPI_Count *lb,
                                         MPI_Count *extent);
__attribute__((visibility("default"))) int MPI_Type_get_name(MPI_Datatype type, char *type_name,
                                     int *resultlen);
__attribute__((visibility("default"))) int MPI_Type_get_true_extent(MPI_Datatype datatype, MPI_Aint *true_lb,
                                            MPI_Aint *true_extent);
__attribute__((visibility("default"))) int MPI_Type_get_true_extent_x(MPI_Datatype datatype, MPI_Count *true_lb,
                                              MPI_Count *true_extent);
__attribute__((visibility("default"))) int MPI_Type_hindexed(int count, int array_of_blocklengths[],
                                     MPI_Aint array_of_displacements[],
                                     MPI_Datatype oldtype, MPI_Datatype *newtype)
                                     __attribute__((__deprecated__));
__attribute__((visibility("default"))) int MPI_Type_hvector(int count, int blocklength, MPI_Aint stride,
                                    MPI_Datatype oldtype, MPI_Datatype *newtype)
                                    __attribute__((__deprecated__));
__attribute__((visibility("default"))) int MPI_Type_indexed(int count, const int array_of_blocklengths[],
                                    const int array_of_displacements[],
                                    MPI_Datatype oldtype, MPI_Datatype *newtype);
__attribute__((visibility("default"))) int MPI_Type_lb(MPI_Datatype type, MPI_Aint *lb)
                               __attribute__((__deprecated__));
__attribute__((visibility("default"))) int MPI_Type_match_size(int typeclass, int size, MPI_Datatype *type);
__attribute__((visibility("default"))) int MPI_Type_set_attr(MPI_Datatype type, int type_keyval,
                                     void *attr_val);
__attribute__((visibility("default"))) int MPI_Type_set_name(MPI_Datatype type, const char *type_name);
__attribute__((visibility("default"))) int MPI_Type_size(MPI_Datatype type, int *size);
__attribute__((visibility("default"))) int MPI_Type_size_x(MPI_Datatype type, MPI_Count *size);
__attribute__((visibility("default"))) int MPI_Type_struct(int count, int array_of_blocklengths[],
                                   MPI_Aint array_of_displacements[],
                                   MPI_Datatype array_of_types[],
                                   MPI_Datatype *newtype)
                                   __attribute__((__deprecated__));
__attribute__((visibility("default"))) int MPI_Type_ub(MPI_Datatype mtype, MPI_Aint *ub)
                               __attribute__((__deprecated__));
__attribute__((visibility("default"))) int MPI_Type_vector(int count, int blocklength, int stride,
                                   MPI_Datatype oldtype, MPI_Datatype *newtype);
__attribute__((visibility("default"))) int MPI_Unpack(const void *inbuf, int insize, int *position,
                              void *outbuf, int outcount, MPI_Datatype datatype,
                              MPI_Comm comm);
__attribute__((visibility("default"))) int MPI_Unpublish_name(const char *service_name, MPI_Info info, const char *port_name);
__attribute__((visibility("default"))) int MPI_Unpack_external (const char datarep[], const void *inbuf, MPI_Aint insize,
                                        MPI_Aint *position, void *outbuf, int outcount,
                                        MPI_Datatype datatype);
__attribute__((visibility("default"))) int MPI_Waitall(int count, MPI_Request array_of_requests[],
                               MPI_Status *array_of_statuses);
__attribute__((visibility("default"))) int MPI_Waitany(int count, MPI_Request array_of_requests[],
                               int *index, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_Wait(MPI_Request *request, MPI_Status *status);
__attribute__((visibility("default"))) int MPI_Waitsome(int incount, MPI_Request array_of_requests[],
                                int *outcount, int array_of_indices[],
                                MPI_Status array_of_statuses[]);
__attribute__((visibility("default"))) int MPI_Win_allocate(MPI_Aint size, int disp_unit, MPI_Info info,
                                    MPI_Comm comm, void *baseptr, MPI_Win *win);
__attribute__((visibility("default"))) int MPI_Win_allocate_shared(MPI_Aint size, int disp_unit, MPI_Info info,
                                           MPI_Comm comm, void *baseptr, MPI_Win *win);
__attribute__((visibility("default"))) int MPI_Win_attach(MPI_Win win, void *base, MPI_Aint size);
__attribute__((visibility("default"))) int MPI_Win_c2f(MPI_Win win);
__attribute__((visibility("default"))) int MPI_Win_call_errhandler(MPI_Win win, int errorcode);
__attribute__((visibility("default"))) int MPI_Win_complete(MPI_Win win);
__attribute__((visibility("default"))) int MPI_Win_create(void *base, MPI_Aint size, int disp_unit,
                                  MPI_Info info, MPI_Comm comm, MPI_Win *win);
__attribute__((visibility("default"))) int MPI_Win_create_dynamic(MPI_Info info, MPI_Comm comm, MPI_Win *win);
__attribute__((visibility("default"))) int MPI_Win_create_errhandler(MPI_Win_errhandler_function *function,
                                             MPI_Errhandler *errhandler);
__attribute__((visibility("default"))) int MPI_Win_create_keyval(MPI_Win_copy_attr_function *win_copy_attr_fn,
                                         MPI_Win_delete_attr_function *win_delete_attr_fn,
                                         int *win_keyval, void *extra_state);
__attribute__((visibility("default"))) int MPI_Win_delete_attr(MPI_Win win, int win_keyval);
__attribute__((visibility("default"))) int MPI_Win_detach(MPI_Win win, const void *base);
__attribute__((visibility("default"))) MPI_Win MPI_Win_f2c(int win);
__attribute__((visibility("default"))) int MPI_Win_fence(int assert, MPI_Win win);
__attribute__((visibility("default"))) int MPI_Win_flush(int rank, MPI_Win win);
__attribute__((visibility("default"))) int MPI_Win_flush_all(MPI_Win win);
__attribute__((visibility("default"))) int MPI_Win_flush_local(int rank, MPI_Win win);
__attribute__((visibility("default"))) int MPI_Win_flush_local_all(MPI_Win win);
__attribute__((visibility("default"))) int MPI_Win_free(MPI_Win *win);
__attribute__((visibility("default"))) int MPI_Win_free_keyval(int *win_keyval);
__attribute__((visibility("default"))) int MPI_Win_get_attr(MPI_Win win, int win_keyval,
                                    void *attribute_val, int *flag);
__attribute__((visibility("default"))) int MPI_Win_get_errhandler(MPI_Win win, MPI_Errhandler *errhandler);
__attribute__((visibility("default"))) int MPI_Win_get_group(MPI_Win win, MPI_Group *group);
__attribute__((visibility("default"))) int MPI_Win_get_info(MPI_Win win, MPI_Info *info_used);
__attribute__((visibility("default"))) int MPI_Win_get_name(MPI_Win win, char *win_name, int *resultlen);
__attribute__((visibility("default"))) int MPI_Win_lock(int lock_type, int rank, int assert, MPI_Win win);
__attribute__((visibility("default"))) int MPI_Win_lock_all(int assert, MPI_Win win);
__attribute__((visibility("default"))) int MPI_Win_post(MPI_Group group, int assert, MPI_Win win);
__attribute__((visibility("default"))) int MPI_Win_set_attr(MPI_Win win, int win_keyval, void *attribute_val);
__attribute__((visibility("default"))) int MPI_Win_set_errhandler(MPI_Win win, MPI_Errhandler errhandler);
__attribute__((visibility("default"))) int MPI_Win_set_info(MPI_Win win, MPI_Info info);
__attribute__((visibility("default"))) int MPI_Win_set_name(MPI_Win win, const char *win_name);
__attribute__((visibility("default"))) int MPI_Win_shared_query(MPI_Win win, int rank, MPI_Aint *size, int *disp_unit, void *baseptr);
__attribute__((visibility("default"))) int MPI_Win_start(MPI_Group group, int assert, MPI_Win win);
__attribute__((visibility("default"))) int MPI_Win_sync(MPI_Win win);
__attribute__((visibility("default"))) int MPI_Win_test(MPI_Win win, int *flag);
__attribute__((visibility("default"))) int MPI_Win_unlock(int rank, MPI_Win win);
__attribute__((visibility("default"))) int MPI_Win_unlock_all(MPI_Win win);
__attribute__((visibility("default"))) int MPI_Win_wait(MPI_Win win);
__attribute__((visibility("default"))) double MPI_Wtick(void);
__attribute__((visibility("default"))) double MPI_Wtime(void);




__attribute__((visibility("default"))) int PMPI_Abort(MPI_Comm comm, int errorcode);
__attribute__((visibility("default"))) int PMPI_Accumulate(const void *origin_addr, int origin_count, MPI_Datatype origin_datatype,
                                   int target_rank, MPI_Aint target_disp, int target_count,
                                   MPI_Datatype target_datatype, MPI_Op op, MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Add_error_class(int *errorclass);
__attribute__((visibility("default"))) int PMPI_Add_error_code(int errorclass, int *errorcode);
__attribute__((visibility("default"))) int PMPI_Add_error_string(int errorcode, const char *string);
__attribute__((visibility("default"))) int PMPI_Address(void *location, MPI_Aint *address)
                                __attribute__((__deprecated__));
__attribute__((visibility("default"))) int PMPI_Allgather(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                  void *recvbuf, int recvcount,
                                  MPI_Datatype recvtype, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Iallgather(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                  void *recvbuf, int recvcount,
                                  MPI_Datatype recvtype, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Allgatherv(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                   void *recvbuf, const int recvcounts[],
                                   const int displs[], MPI_Datatype recvtype, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Iallgatherv(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                   void *recvbuf, const int recvcounts[],
                                   const int displs[], MPI_Datatype recvtype, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Alloc_mem(MPI_Aint size, MPI_Info info,
                                  void *baseptr);
__attribute__((visibility("default"))) int PMPI_Allreduce(const void *sendbuf, void *recvbuf, int count,
                                  MPI_Datatype datatype, MPI_Op op, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Iallreduce(const void *sendbuf, void *recvbuf, int count,
                                  MPI_Datatype datatype, MPI_Op op, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Alltoall(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                 void *recvbuf, int recvcount,
                                 MPI_Datatype recvtype, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Ialltoall(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                 void *recvbuf, int recvcount,
                                 MPI_Datatype recvtype, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Alltoallv(const void *sendbuf, const int sendcounts[], const int sdispls[],
                                  MPI_Datatype sendtype, void *recvbuf, const int recvcounts[],
                                  const int rdispls[], MPI_Datatype recvtype, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Ialltoallv(const void *sendbuf, const int sendcounts[], const int sdispls[],
                                  MPI_Datatype sendtype, void *recvbuf, const int recvcounts[],
                                  const int rdispls[], MPI_Datatype recvtype, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Alltoallw(const void *sendbuf, const int sendcounts[], const int sdispls[], const MPI_Datatype sendtypes[],
                                  void *recvbuf, const int recvcounts[], const int rdispls[], const MPI_Datatype recvtypes[],
                                  MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Ialltoallw(const void *sendbuf, const int sendcounts[], const int sdispls[], const MPI_Datatype sendtypes[],
                                  void *recvbuf, const int recvcounts[], const int rdispls[], const MPI_Datatype recvtypes[],
                                  MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Attr_delete(MPI_Comm comm, int keyval)
                                    __attribute__((__deprecated__));
__attribute__((visibility("default"))) int PMPI_Attr_get(MPI_Comm comm, int keyval, void *attribute_val, int *flag)
                                 __attribute__((__deprecated__));
__attribute__((visibility("default"))) int PMPI_Dist_graph_create(MPI_Comm comm_old, int n, const int nodes[],
                                          const int degrees[], const int targets[],
                                          const int weights[], MPI_Info info,
                                          int reorder, MPI_Comm * newcomm);
__attribute__((visibility("default"))) int PMPI_Dist_graph_create_adjacent(MPI_Comm comm_old,
                                                   int indegree, const int sources[],
                                                   const int sourceweights[],
                                                   int outdegree,
                                                   const int destinations[],
                                                   const int destweights[],
                                                   MPI_Info info, int reorder,
                                                   MPI_Comm *comm_dist_graph);
__attribute__((visibility("default"))) int PMPI_Dist_graph_neighbors(MPI_Comm comm, int maxindegree,
                                            int sources[], int sourceweights[],
                                            int maxoutdegree,
                                             int destinations[],
                                            int destweights[]);
__attribute__((visibility("default"))) int PMPI_Dist_graph_neighbors_count(MPI_Comm comm,
                                                   int *inneighbors,
                                                   int *outneighbors,
                                                   int *weighted);
__attribute__((visibility("default"))) int PMPI_Attr_put(MPI_Comm comm, int keyval, void *attribute_val)
                                 __attribute__((__deprecated__));
__attribute__((visibility("default"))) int PMPI_Barrier(MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Ibarrier(MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Bcast(void *buffer, int count, MPI_Datatype datatype,
                              int root, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Ibcast(void *buffer, int count, MPI_Datatype datatype,
                                  int root, MPI_Comm comm,
             MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Bsend(const void *buf, int count, MPI_Datatype datatype,
                              int dest, int tag, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Bsend_init(const void *buf, int count, MPI_Datatype datatype,
                                   int dest, int tag, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Buffer_attach(void *buffer, int size);
__attribute__((visibility("default"))) int PMPI_Buffer_detach(void *buffer, int *size);
__attribute__((visibility("default"))) int PMPI_Cancel(MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Cart_coords(MPI_Comm comm, int rank, int maxdims, int coords[]);
__attribute__((visibility("default"))) int PMPI_Cart_create(MPI_Comm old_comm, int ndims, const int dims[],
                                    const int periods[], int reorder, MPI_Comm *comm_cart);
__attribute__((visibility("default"))) int PMPI_Cart_get(MPI_Comm comm, int maxdims, int dims[],
                                 int periods[], int coords[]);
__attribute__((visibility("default"))) int PMPI_Cart_map(MPI_Comm comm, int ndims, const int dims[],
                                 const int periods[], int *newrank);
__attribute__((visibility("default"))) int PMPI_Cart_rank(MPI_Comm comm, const int coords[], int *rank);
__attribute__((visibility("default"))) int PMPI_Cart_shift(MPI_Comm comm, int direction, int disp,
                                   int *rank_source, int *rank_dest);
__attribute__((visibility("default"))) int PMPI_Cart_sub(MPI_Comm comm, const int remain_dims[], MPI_Comm *new_comm);
__attribute__((visibility("default"))) int PMPI_Cartdim_get(MPI_Comm comm, int *ndims);
__attribute__((visibility("default"))) int PMPI_Close_port(const char *port_name);
__attribute__((visibility("default"))) int PMPI_Comm_accept(const char *port_name, MPI_Info info, int root,
                                    MPI_Comm comm, MPI_Comm *newcomm);
__attribute__((visibility("default"))) int PMPI_Comm_c2f(MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Comm_call_errhandler(MPI_Comm comm, int errorcode);
__attribute__((visibility("default"))) int PMPI_Comm_compare(MPI_Comm comm1, MPI_Comm comm2, int *result);
__attribute__((visibility("default"))) int PMPI_Comm_connect(const char *port_name, MPI_Info info, int root,
                                     MPI_Comm comm, MPI_Comm *newcomm);
__attribute__((visibility("default"))) int PMPI_Comm_create_errhandler(MPI_Comm_errhandler_function *function,
                                               MPI_Errhandler *errhandler);
__attribute__((visibility("default"))) int PMPI_Comm_create_keyval(MPI_Comm_copy_attr_function *comm_copy_attr_fn,
                                           MPI_Comm_delete_attr_function *comm_delete_attr_fn,
                                           int *comm_keyval, void *extra_state);
__attribute__((visibility("default"))) int PMPI_Comm_create_group(MPI_Comm comm, MPI_Group group, int tag, MPI_Comm *newcomm);
__attribute__((visibility("default"))) int PMPI_Comm_create(MPI_Comm comm, MPI_Group group, MPI_Comm *newcomm);
__attribute__((visibility("default"))) int PMPI_Comm_delete_attr(MPI_Comm comm, int comm_keyval);
__attribute__((visibility("default"))) int PMPI_Comm_disconnect(MPI_Comm *comm);
__attribute__((visibility("default"))) int PMPI_Comm_dup(MPI_Comm comm, MPI_Comm *newcomm);
__attribute__((visibility("default"))) int PMPI_Comm_idup(MPI_Comm comm, MPI_Comm *newcomm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Comm_dup_with_info(MPI_Comm comm, MPI_Info info, MPI_Comm *newcomm);
__attribute__((visibility("default"))) MPI_Comm PMPI_Comm_f2c(int comm);
__attribute__((visibility("default"))) int PMPI_Comm_free_keyval(int *comm_keyval);
__attribute__((visibility("default"))) int PMPI_Comm_free(MPI_Comm *comm);
__attribute__((visibility("default"))) int PMPI_Comm_get_attr(MPI_Comm comm, int comm_keyval,
                                      void *attribute_val, int *flag);
__attribute__((visibility("default"))) int PMPI_Comm_get_errhandler(MPI_Comm comm, MPI_Errhandler *erhandler);
__attribute__((visibility("default"))) int PMPI_Comm_get_info(MPI_Comm comm, MPI_Info *info_used);
__attribute__((visibility("default"))) int PMPI_Comm_get_name(MPI_Comm comm, char *comm_name, int *resultlen);
__attribute__((visibility("default"))) int PMPI_Comm_get_parent(MPI_Comm *parent);
__attribute__((visibility("default"))) int PMPI_Comm_group(MPI_Comm comm, MPI_Group *group);
__attribute__((visibility("default"))) int PMPI_Comm_join(int fd, MPI_Comm *intercomm);
__attribute__((visibility("default"))) int PMPI_Comm_rank(MPI_Comm comm, int *rank);
__attribute__((visibility("default"))) int PMPI_Comm_remote_group(MPI_Comm comm, MPI_Group *group);
__attribute__((visibility("default"))) int PMPI_Comm_remote_size(MPI_Comm comm, int *size);
__attribute__((visibility("default"))) int PMPI_Comm_set_attr(MPI_Comm comm, int comm_keyval, void *attribute_val);
__attribute__((visibility("default"))) int PMPI_Comm_set_errhandler(MPI_Comm comm, MPI_Errhandler errhandler);
__attribute__((visibility("default"))) int PMPI_Comm_set_info(MPI_Comm comm, MPI_Info info);
__attribute__((visibility("default"))) int PMPI_Comm_set_name(MPI_Comm comm, const char *comm_name);
__attribute__((visibility("default"))) int PMPI_Comm_size(MPI_Comm comm, int *size);
__attribute__((visibility("default"))) int PMPI_Comm_spawn(const char *command, char *argv[], int maxprocs, MPI_Info info,
                                   int root, MPI_Comm comm, MPI_Comm *intercomm,
                                   int array_of_errcodes[]);
__attribute__((visibility("default"))) int PMPI_Comm_spawn_multiple(int count, char *array_of_commands[], char **array_of_argv[],
                                            const int array_of_maxprocs[], const MPI_Info array_of_info[],
                                            int root, MPI_Comm comm, MPI_Comm *intercomm,
                                            int array_of_errcodes[]);
__attribute__((visibility("default"))) int PMPI_Comm_split(MPI_Comm comm, int color, int key, MPI_Comm *newcomm);
__attribute__((visibility("default"))) int PMPI_Comm_split_type(MPI_Comm comm, int split_type, int key, MPI_Info info, MPI_Comm *newcomm);
__attribute__((visibility("default"))) int PMPI_Comm_test_inter(MPI_Comm comm, int *flag);
__attribute__((visibility("default"))) int PMPI_Compare_and_swap(const void *origin_addr, const void *compare_addr,
                                         void *result_addr, MPI_Datatype datatype, int target_rank,
                                         MPI_Aint target_disp, MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Dims_create(int nnodes, int ndims, int dims[]);
__attribute__((visibility("default"))) int PMPI_Errhandler_c2f(MPI_Errhandler errhandler);
__attribute__((visibility("default"))) int PMPI_Errhandler_create(MPI_Handler_function *function,
                                          MPI_Errhandler *errhandler)
                                          __attribute__((__deprecated__));
__attribute__((visibility("default"))) MPI_Errhandler PMPI_Errhandler_f2c(int errhandler);
__attribute__((visibility("default"))) int PMPI_Errhandler_free(MPI_Errhandler *errhandler);
__attribute__((visibility("default"))) int PMPI_Errhandler_get(MPI_Comm comm, MPI_Errhandler *errhandler)
                                       __attribute__((__deprecated__));
__attribute__((visibility("default"))) int PMPI_Errhandler_set(MPI_Comm comm, MPI_Errhandler errhandler)
                                       __attribute__((__deprecated__));
__attribute__((visibility("default"))) int PMPI_Error_class(int errorcode, int *errorclass);
__attribute__((visibility("default"))) int PMPI_Error_string(int errorcode, char *string, int *resultlen);
__attribute__((visibility("default"))) int PMPI_Exscan(const void *sendbuf, void *recvbuf, int count,
                               MPI_Datatype datatype, MPI_Op op, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Fetch_and_op(const void *origin_addr, void *result_addr, MPI_Datatype datatype,
                                     int target_rank, MPI_Aint target_disp, MPI_Op op, MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Iexscan(const void *sendbuf, void *recvbuf, int count,
                               MPI_Datatype datatype, MPI_Op op, MPI_Comm comm, MPI_Request *request);

__attribute__((visibility("default"))) int PMPI_File_c2f(MPI_File file);
__attribute__((visibility("default"))) MPI_File PMPI_File_f2c(int file);
__attribute__((visibility("default"))) int PMPI_File_call_errhandler(MPI_File fh, int errorcode);
__attribute__((visibility("default"))) int PMPI_File_create_errhandler(MPI_File_errhandler_function *function,
                                               MPI_Errhandler *errhandler);
__attribute__((visibility("default"))) int PMPI_File_set_errhandler( MPI_File file, MPI_Errhandler errhandler);
__attribute__((visibility("default"))) int PMPI_File_get_errhandler( MPI_File file, MPI_Errhandler *errhandler);
__attribute__((visibility("default"))) int PMPI_File_open(MPI_Comm comm, const char *filename, int amode,
                                  MPI_Info info, MPI_File *fh);
__attribute__((visibility("default"))) int PMPI_File_close(MPI_File *fh);
__attribute__((visibility("default"))) int PMPI_File_delete(const char *filename, MPI_Info info);
__attribute__((visibility("default"))) int PMPI_File_set_size(MPI_File fh, MPI_Offset size);
__attribute__((visibility("default"))) int PMPI_File_preallocate(MPI_File fh, MPI_Offset size);
__attribute__((visibility("default"))) int PMPI_File_get_size(MPI_File fh, MPI_Offset *size);
__attribute__((visibility("default"))) int PMPI_File_get_group(MPI_File fh, MPI_Group *group);
__attribute__((visibility("default"))) int PMPI_File_get_amode(MPI_File fh, int *amode);
__attribute__((visibility("default"))) int PMPI_File_set_info(MPI_File fh, MPI_Info info);
__attribute__((visibility("default"))) int PMPI_File_get_info(MPI_File fh, MPI_Info *info_used);
__attribute__((visibility("default"))) int PMPI_File_set_view(MPI_File fh, MPI_Offset disp, MPI_Datatype etype,
                                      MPI_Datatype filetype, const char *datarep, MPI_Info info);
__attribute__((visibility("default"))) int PMPI_File_get_view(MPI_File fh, MPI_Offset *disp,
                                      MPI_Datatype *etype,
                                      MPI_Datatype *filetype, char *datarep);
__attribute__((visibility("default"))) int PMPI_File_read_at(MPI_File fh, MPI_Offset offset, void *buf,
                                     int count, MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_File_read_at_all(MPI_File fh, MPI_Offset offset, void *buf,
                                         int count, MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_File_write_at(MPI_File fh, MPI_Offset offset, const void *buf,
                                      int count, MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_File_write_at_all(MPI_File fh, MPI_Offset offset, const void *buf,
                                          int count, MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_File_iread_at(MPI_File fh, MPI_Offset offset, void *buf,
                                      int count, MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_File_iwrite_at(MPI_File fh, MPI_Offset offset, const void *buf,
                                       int count, MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_File_iread_at_all(MPI_File fh, MPI_Offset offset, void *buf,
                                          int count, MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_File_iwrite_at_all(MPI_File fh, MPI_Offset offset, const void *buf,
                                           int count, MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_File_read(MPI_File fh, void *buf, int count,
                                  MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_File_read_all(MPI_File fh, void *buf, int count,
                                      MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_File_write(MPI_File fh, const void *buf, int count,
                                   MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_File_write_all(MPI_File fh, const void *buf, int count,
                                       MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_File_iread(MPI_File fh, void *buf, int count,
                                   MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_File_iwrite(MPI_File fh, const void *buf, int count,
                                    MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_File_iread_all(MPI_File fh, void *buf, int count,
                                       MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_File_iwrite_all(MPI_File fh, const void *buf, int count,
                                        MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_File_seek(MPI_File fh, MPI_Offset offset, int whence);
__attribute__((visibility("default"))) int PMPI_File_get_position(MPI_File fh, MPI_Offset *offset);
__attribute__((visibility("default"))) int PMPI_File_get_byte_offset(MPI_File fh, MPI_Offset offset,
                                             MPI_Offset *disp);
__attribute__((visibility("default"))) int PMPI_File_read_shared(MPI_File fh, void *buf, int count,
                                         MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_File_write_shared(MPI_File fh, const void *buf, int count,
                                          MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_File_iread_shared(MPI_File fh, void *buf, int count,
                                          MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_File_iwrite_shared(MPI_File fh, const void *buf, int count,
                                           MPI_Datatype datatype, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_File_read_ordered(MPI_File fh, void *buf, int count,
                                          MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_File_write_ordered(MPI_File fh, const void *buf, int count,
                                           MPI_Datatype datatype, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_File_seek_shared(MPI_File fh, MPI_Offset offset, int whence);
__attribute__((visibility("default"))) int PMPI_File_get_position_shared(MPI_File fh, MPI_Offset *offset);
__attribute__((visibility("default"))) int PMPI_File_read_at_all_begin(MPI_File fh, MPI_Offset offset, void *buf,
                                               int count, MPI_Datatype datatype);
__attribute__((visibility("default"))) int PMPI_File_read_at_all_end(MPI_File fh, void *buf, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_File_write_at_all_begin(MPI_File fh, MPI_Offset offset, const void *buf,
                                                int count, MPI_Datatype datatype);
__attribute__((visibility("default"))) int PMPI_File_write_at_all_end(MPI_File fh, const void *buf, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_File_read_all_begin(MPI_File fh, void *buf, int count,
                                            MPI_Datatype datatype);
__attribute__((visibility("default"))) int PMPI_File_read_all_end(MPI_File fh, void *buf, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_File_write_all_begin(MPI_File fh, const void *buf, int count,
                                             MPI_Datatype datatype);
__attribute__((visibility("default"))) int PMPI_File_write_all_end(MPI_File fh, const void *buf, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_File_read_ordered_begin(MPI_File fh, void *buf, int count,
                                                MPI_Datatype datatype);
__attribute__((visibility("default"))) int PMPI_File_read_ordered_end(MPI_File fh, void *buf, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_File_write_ordered_begin(MPI_File fh, const void *buf, int count,
                                                 MPI_Datatype datatype);
__attribute__((visibility("default"))) int PMPI_File_write_ordered_end(MPI_File fh, const void *buf, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_File_get_type_extent(MPI_File fh, MPI_Datatype datatype,
                                             MPI_Aint *extent);
__attribute__((visibility("default"))) int PMPI_File_set_atomicity(MPI_File fh, int flag);
__attribute__((visibility("default"))) int PMPI_File_get_atomicity(MPI_File fh, int *flag);
__attribute__((visibility("default"))) int PMPI_File_sync(MPI_File fh);

__attribute__((visibility("default"))) int PMPI_Finalize(void);
__attribute__((visibility("default"))) int PMPI_Finalized(int *flag);
__attribute__((visibility("default"))) int PMPI_Free_mem(void *base);
__attribute__((visibility("default"))) int PMPI_Gather(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                               void *recvbuf, int recvcount, MPI_Datatype recvtype,
                               int root, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Igather(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                               void *recvbuf, int recvcount, MPI_Datatype recvtype,
                               int root, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Gatherv(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                void *recvbuf, const int recvcounts[], const int displs[],
                                MPI_Datatype recvtype, int root, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Igatherv(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                void *recvbuf, const int recvcounts[], const int displs[],
                                MPI_Datatype recvtype, int root, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Get_address(const void *location, MPI_Aint *address);
__attribute__((visibility("default"))) int PMPI_Get_count(const MPI_Status *status, MPI_Datatype datatype, int *count);
__attribute__((visibility("default"))) int PMPI_Get_elements(const MPI_Status *status, MPI_Datatype datatype,
                                     int *count);
__attribute__((visibility("default"))) int PMPI_Get_elements_x(const MPI_Status *status, MPI_Datatype datatype,
                                       MPI_Count *count);
__attribute__((visibility("default"))) int PMPI_Get(void *origin_addr, int origin_count,
                            MPI_Datatype origin_datatype, int target_rank,
                            MPI_Aint target_disp, int target_count,
                            MPI_Datatype target_datatype, MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Get_accumulate(const void *origin_addr, int origin_count, MPI_Datatype origin_datatype,
                                       void *result_addr, int result_count, MPI_Datatype result_datatype,
                                       int target_rank, MPI_Aint target_disp, int target_count,
                                       MPI_Datatype target_datatype, MPI_Op op, MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Get_library_version(char *version, int *resultlen);
__attribute__((visibility("default"))) int PMPI_Get_processor_name(char *name, int *resultlen);
__attribute__((visibility("default"))) int PMPI_Get_version(int *version, int *subversion);
__attribute__((visibility("default"))) int PMPI_Graph_create(MPI_Comm comm_old, int nnodes, const int index[],
                                     const int edges[], int reorder, MPI_Comm *comm_graph);
__attribute__((visibility("default"))) int PMPI_Graph_get(MPI_Comm comm, int maxindex, int maxedges,
                                  int index[], int edges[]);
__attribute__((visibility("default"))) int PMPI_Graph_map(MPI_Comm comm, int nnodes, const int index[], const int edges[],
                                  int *newrank);
__attribute__((visibility("default"))) int PMPI_Graph_neighbors_count(MPI_Comm comm, int rank, int *nneighbors);
__attribute__((visibility("default"))) int PMPI_Graph_neighbors(MPI_Comm comm, int rank, int maxneighbors,
                                        int neighbors[]);
__attribute__((visibility("default"))) int PMPI_Graphdims_get(MPI_Comm comm, int *nnodes, int *nedges);
__attribute__((visibility("default"))) int PMPI_Grequest_complete(MPI_Request request);
__attribute__((visibility("default"))) int PMPI_Grequest_start(MPI_Grequest_query_function *query_fn,
                                       MPI_Grequest_free_function *free_fn,
                                       MPI_Grequest_cancel_function *cancel_fn,
                                       void *extra_state, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Group_c2f(MPI_Group group);
__attribute__((visibility("default"))) int PMPI_Group_compare(MPI_Group group1, MPI_Group group2, int *result);
__attribute__((visibility("default"))) int PMPI_Group_difference(MPI_Group group1, MPI_Group group2,
                                         MPI_Group *newgroup);
__attribute__((visibility("default"))) int PMPI_Group_excl(MPI_Group group, int n, const int ranks[],
                                   MPI_Group *newgroup);
__attribute__((visibility("default"))) MPI_Group PMPI_Group_f2c(int group);
__attribute__((visibility("default"))) int PMPI_Group_free(MPI_Group *group);
__attribute__((visibility("default"))) int PMPI_Group_incl(MPI_Group group, int n, const int ranks[],
                                   MPI_Group *newgroup);
__attribute__((visibility("default"))) int PMPI_Group_intersection(MPI_Group group1, MPI_Group group2,
                                           MPI_Group *newgroup);
__attribute__((visibility("default"))) int PMPI_Group_range_excl(MPI_Group group, int n, int ranges[][3],
                                         MPI_Group *newgroup);
__attribute__((visibility("default"))) int PMPI_Group_range_incl(MPI_Group group, int n, int ranges[][3],
                                         MPI_Group *newgroup);
__attribute__((visibility("default"))) int PMPI_Group_rank(MPI_Group group, int *rank);
__attribute__((visibility("default"))) int PMPI_Group_size(MPI_Group group, int *size);
__attribute__((visibility("default"))) int PMPI_Group_translate_ranks(MPI_Group group1, int n, const int ranks1[],
                                              MPI_Group group2, int ranks2[]);
__attribute__((visibility("default"))) int PMPI_Group_union(MPI_Group group1, MPI_Group group2,
                                    MPI_Group *newgroup);
__attribute__((visibility("default"))) int PMPI_Ibsend(const void *buf, int count, MPI_Datatype datatype, int dest,
                               int tag, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Improbe(int source, int tag, MPI_Comm comm,
                                int *flag, MPI_Message *message,
                                MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_Imrecv(void *buf, int count, MPI_Datatype type,
                               MPI_Message *message, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Info_c2f(MPI_Info info);
__attribute__((visibility("default"))) int PMPI_Info_create(MPI_Info *info);
__attribute__((visibility("default"))) int PMPI_Info_delete(MPI_Info info, const char *key);
__attribute__((visibility("default"))) int PMPI_Info_dup(MPI_Info info, MPI_Info *newinfo);
__attribute__((visibility("default"))) MPI_Info PMPI_Info_f2c(int info);
__attribute__((visibility("default"))) int PMPI_Info_free(MPI_Info *info);
__attribute__((visibility("default"))) int PMPI_Info_get(MPI_Info info, const char *key, int valuelen,
                                 char *value, int *flag);
__attribute__((visibility("default"))) int PMPI_Info_get_nkeys(MPI_Info info, int *nkeys);
__attribute__((visibility("default"))) int PMPI_Info_get_nthkey(MPI_Info info, int n, char *key);
__attribute__((visibility("default"))) int PMPI_Info_get_valuelen(MPI_Info info, const char *key, int *valuelen,
                                          int *flag);
__attribute__((visibility("default"))) int PMPI_Info_set(MPI_Info info, const char *key, const char *value);
__attribute__((visibility("default"))) int PMPI_Init(int *argc, char ***argv);
__attribute__((visibility("default"))) int PMPI_Initialized(int *flag);
__attribute__((visibility("default"))) int PMPI_Init_thread(int *argc, char ***argv, int required,
                                    int *provided);
__attribute__((visibility("default"))) int PMPI_Intercomm_create(MPI_Comm local_comm, int local_leader,
                                         MPI_Comm bridge_comm, int remote_leader,
                                         int tag, MPI_Comm *newintercomm);
__attribute__((visibility("default"))) int PMPI_Intercomm_merge(MPI_Comm intercomm, int high,
                                        MPI_Comm *newintercomm);
__attribute__((visibility("default"))) int PMPI_Iprobe(int source, int tag, MPI_Comm comm, int *flag,
                               MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_Irecv(void *buf, int count, MPI_Datatype datatype, int source,
                              int tag, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Irsend(const void *buf, int count, MPI_Datatype datatype, int dest,
                               int tag, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Isend(const void *buf, int count, MPI_Datatype datatype, int dest,
                              int tag, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Issend(const void *buf, int count, MPI_Datatype datatype, int dest,
                               int tag, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Is_thread_main(int *flag);
__attribute__((visibility("default"))) int PMPI_Keyval_create(MPI_Copy_function *copy_fn,
                                      MPI_Delete_function *delete_fn,
                                      int *keyval, void *extra_state)
                                      __attribute__((__deprecated__));
__attribute__((visibility("default"))) int PMPI_Keyval_free(int *keyval)
                                    __attribute__((__deprecated__));
__attribute__((visibility("default"))) int PMPI_Lookup_name(const char *service_name, MPI_Info info, char *port_name);
__attribute__((visibility("default"))) int PMPI_Message_c2f(MPI_Message message);
__attribute__((visibility("default"))) MPI_Message PMPI_Message_f2c(int message);
__attribute__((visibility("default"))) int PMPI_Mprobe(int source, int tag, MPI_Comm comm,
                               MPI_Message *message,
                               MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_Mrecv(void *buf, int count, MPI_Datatype type,
                              MPI_Message *message, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_Neighbor_allgather(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                           void *recvbuf, int recvcount, MPI_Datatype recvtype,
                                           MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Ineighbor_allgather(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                            void *recvbuf, int recvcount, MPI_Datatype recvtype,
                                            MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Neighbor_allgatherv(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                            void *recvbuf, const int recvcounts[], const int displs[],
                                            MPI_Datatype recvtype, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Ineighbor_allgatherv(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                             void *recvbuf, const int recvcounts[], const int displs[],
                                             MPI_Datatype recvtype, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Neighbor_alltoall(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                          void *recvbuf, int recvcount, MPI_Datatype recvtype,
                                          MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Ineighbor_alltoall(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                           void *recvbuf, int recvcount, MPI_Datatype recvtype,
                                           MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Neighbor_alltoallv(const void *sendbuf, const int sendcounts[], const int sdispls[], MPI_Datatype sendtype,
                                           void *recvbuf, const int recvcounts[], const int rdispls[], MPI_Datatype recvtype,
                                           MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Ineighbor_alltoallv(const void *sendbuf, const int sendcounts[], const int sdispls[], MPI_Datatype sendtype,
                                            void *recvbuf, const int recvcounts[], const int rdispls[], MPI_Datatype recvtype,
                                            MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Neighbor_alltoallw(const void *sendbuf, const int sendcounts[], const MPI_Aint sdispls[], const MPI_Datatype sendtypes[],
                                           void *recvbuf, const int recvcounts[], const MPI_Aint rdispls[], const MPI_Datatype recvtypes[],
                                           MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Ineighbor_alltoallw(const void *sendbuf, const int sendcounts[], const MPI_Aint sdispls[], const MPI_Datatype sendtypes[],
                                            void *recvbuf, const int recvcounts[], const MPI_Aint rdispls[], const MPI_Datatype recvtypes[],
                                            MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Op_c2f(MPI_Op op);
__attribute__((visibility("default"))) int PMPI_Op_commutative(MPI_Op op, int *commute);
__attribute__((visibility("default"))) int PMPI_Op_create(MPI_User_function *function, int commute, MPI_Op *op);
__attribute__((visibility("default"))) int PMPI_Open_port(MPI_Info info, char *port_name);
__attribute__((visibility("default"))) MPI_Op PMPI_Op_f2c(int op);
__attribute__((visibility("default"))) int PMPI_Op_free(MPI_Op *op);
__attribute__((visibility("default"))) int PMPI_Pack_external(const char datarep[], const void *inbuf, int incount,
                                      MPI_Datatype datatype, void *outbuf,
                                      MPI_Aint outsize, MPI_Aint *position);
__attribute__((visibility("default"))) int PMPI_Pack_external_size(const char datarep[], int incount,
                                           MPI_Datatype datatype, MPI_Aint *size);
__attribute__((visibility("default"))) int PMPI_Pack(const void *inbuf, int incount, MPI_Datatype datatype,
                             void *outbuf, int outsize, int *position, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Pack_size(int incount, MPI_Datatype datatype, MPI_Comm comm,
                                  int *size);
__attribute__((visibility("default"))) int PMPI_Pcontrol(const int level, ...);
__attribute__((visibility("default"))) int PMPI_Probe(int source, int tag, MPI_Comm comm, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_Publish_name(const char *service_name, MPI_Info info,
                                     const char *port_name);
__attribute__((visibility("default"))) int PMPI_Put(const void *origin_addr, int origin_count, MPI_Datatype origin_datatype,
                            int target_rank, MPI_Aint target_disp, int target_count,
                            MPI_Datatype target_datatype, MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Query_thread(int *provided);
__attribute__((visibility("default"))) int PMPI_Raccumulate(const void *origin_addr, int origin_count, MPI_Datatype origin_datatype,
                                    int target_rank, MPI_Aint target_disp, int target_count,
                                    MPI_Datatype target_datatype, MPI_Op op, MPI_Win win, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Recv_init(void *buf, int count, MPI_Datatype datatype, int source,
                                  int tag, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Recv(void *buf, int count, MPI_Datatype datatype, int source,
                             int tag, MPI_Comm comm, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_Reduce(const void *sendbuf, void *recvbuf, int count,
                               MPI_Datatype datatype, MPI_Op op, int root, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Ireduce(const void *sendbuf, void *recvbuf, int count,
                               MPI_Datatype datatype, MPI_Op op, int root, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Reduce_local(const void *inbuf, void *inoutbuf, int count,
                                     MPI_Datatype datatype, MPI_Op);
__attribute__((visibility("default"))) int PMPI_Reduce_scatter(const void *sendbuf, void *recvbuf, const int recvcounts[],
                                       MPI_Datatype datatype, MPI_Op op, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Ireduce_scatter(const void *sendbuf, void *recvbuf, const int recvcounts[],
                                        MPI_Datatype datatype, MPI_Op op, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Reduce_scatter_block(const void *sendbuf, void *recvbuf, int recvcount,
                                             MPI_Datatype datatype, MPI_Op op, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Ireduce_scatter_block(const void *sendbuf, void *recvbuf, int recvcount,
                                              MPI_Datatype datatype, MPI_Op op, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Register_datarep(const char *datarep,
                                         MPI_Datarep_conversion_function *read_conversion_fn,
                                         MPI_Datarep_conversion_function *write_conversion_fn,
                                         MPI_Datarep_extent_function *dtype_file_extent_fn,
                                         void *extra_state);
__attribute__((visibility("default"))) int PMPI_Request_c2f(MPI_Request request);
__attribute__((visibility("default"))) MPI_Request PMPI_Request_f2c(int request);
__attribute__((visibility("default"))) int PMPI_Request_free(MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Request_get_status(MPI_Request request, int *flag,
                                           MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_Rget(void *origin_addr, int origin_count, MPI_Datatype origin_datatype,
                             int target_rank, MPI_Aint target_disp, int target_count, MPI_Datatype target_datatype,
                             MPI_Win win, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Rget_accumulate(const void *origin_addr, int origin_count, MPI_Datatype origin_datatype,
                                        void *result_addr, int result_count, MPI_Datatype result_datatype,
                                        int target_rank, MPI_Aint target_disp, int target_count,
                                        MPI_Datatype target_datatype, MPI_Op op,
                                        MPI_Win win, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Rput(const void *origin_addr, int origin_count, MPI_Datatype origin_datatype,
                             int target_rank, MPI_Aint target_disp, int target_cout,
                             MPI_Datatype target_datatype, MPI_Win win, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Rsend(const void *ibuf, int count, MPI_Datatype datatype, int dest,
                              int tag, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Rsend_init(const void *buf, int count, MPI_Datatype datatype,
                                   int dest, int tag, MPI_Comm comm,
                                   MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Scan(const void *sendbuf, void *recvbuf, int count,
                             MPI_Datatype datatype, MPI_Op op, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Iscan(const void *sendbuf, void *recvbuf, int count,
                             MPI_Datatype datatype, MPI_Op op, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Scatter(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                void *recvbuf, int recvcount, MPI_Datatype recvtype,
                                int root, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Iscatter(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                void *recvbuf, int recvcount, MPI_Datatype recvtype,
                                int root, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Scatterv(const void *sendbuf, const int sendcounts[], const int displs[],
                                 MPI_Datatype sendtype, void *recvbuf, int recvcount,
                                 MPI_Datatype recvtype, int root, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Iscatterv(const void *sendbuf, const int sendcounts[], const int displs[],
                                 MPI_Datatype sendtype, void *recvbuf, int recvcount,
                                 MPI_Datatype recvtype, int root, MPI_Comm comm, MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Send_init(const void *buf, int count, MPI_Datatype datatype,
                                  int dest, int tag, MPI_Comm comm,
                                  MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Send(const void *buf, int count, MPI_Datatype datatype, int dest,
                             int tag, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Sendrecv(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
                                 int dest, int sendtag, void *recvbuf, int recvcount,
                                 MPI_Datatype recvtype, int source, int recvtag,
                                 MPI_Comm comm, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_Sendrecv_replace(void * buf, int count, MPI_Datatype datatype,
                                         int dest, int sendtag, int source, int recvtag,
                                         MPI_Comm comm, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_Ssend_init(const void *buf, int count, MPI_Datatype datatype,
                                   int dest, int tag, MPI_Comm comm,
                                   MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Ssend(const void *buf, int count, MPI_Datatype datatype, int dest,
                              int tag, MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Start(MPI_Request *request);
__attribute__((visibility("default"))) int PMPI_Startall(int count, MPI_Request array_of_requests[]);
__attribute__((visibility("default"))) int PMPI_Status_c2f(const MPI_Status *c_status, int *f_status);
__attribute__((visibility("default"))) int PMPI_Status_f2c(const int *f_status, MPI_Status *c_status);
__attribute__((visibility("default"))) int PMPI_Status_set_cancelled(MPI_Status *status, int flag);
__attribute__((visibility("default"))) int PMPI_Status_set_elements(MPI_Status *status, MPI_Datatype datatype,
                                            int count);
__attribute__((visibility("default"))) int PMPI_Status_set_elements_x(MPI_Status *status, MPI_Datatype datatype,
                                              MPI_Count count);
__attribute__((visibility("default"))) int PMPI_Testall(int count, MPI_Request array_of_requests[], int *flag,
                                MPI_Status array_of_statuses[]);
__attribute__((visibility("default"))) int PMPI_Testany(int count, MPI_Request array_of_requests[], int *index, int *flag, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_Test(MPI_Request *request, int *flag, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_Test_cancelled(const MPI_Status *status, int *flag);
__attribute__((visibility("default"))) int PMPI_Testsome(int incount, MPI_Request array_of_requests[],
                                 int *outcount, int array_of_indices[],
                                 MPI_Status array_of_statuses[]);
__attribute__((visibility("default"))) int PMPI_Topo_test(MPI_Comm comm, int *status);
__attribute__((visibility("default"))) int PMPI_Type_c2f(MPI_Datatype datatype);
__attribute__((visibility("default"))) int PMPI_Type_commit(MPI_Datatype *type);
__attribute__((visibility("default"))) int PMPI_Type_contiguous(int count, MPI_Datatype oldtype,
                                        MPI_Datatype *newtype);
__attribute__((visibility("default"))) int PMPI_Type_create_darray(int size, int rank, int ndims,
                                           const int gsize_array[], const int distrib_array[],
                                           const int darg_array[], const int psize_array[],
                                           int order, MPI_Datatype oldtype,
                                           MPI_Datatype *newtype);
__attribute__((visibility("default"))) int PMPI_Type_create_f90_complex(int p, int r, MPI_Datatype *newtype);
__attribute__((visibility("default"))) int PMPI_Type_create_f90_integer(int r, MPI_Datatype *newtype);
__attribute__((visibility("default"))) int PMPI_Type_create_f90_real(int p, int r, MPI_Datatype *newtype);
__attribute__((visibility("default"))) int PMPI_Type_create_hindexed(int count, const int array_of_blocklengths[],
                                             const MPI_Aint array_of_displacements[],
                                             MPI_Datatype oldtype,
                                             MPI_Datatype *newtype);
__attribute__((visibility("default"))) int PMPI_Type_create_hvector(int count, int blocklength, MPI_Aint stride,
                                            MPI_Datatype oldtype,
                                            MPI_Datatype *newtype);
__attribute__((visibility("default"))) int PMPI_Type_create_keyval(MPI_Type_copy_attr_function *type_copy_attr_fn,
                                           MPI_Type_delete_attr_function *type_delete_attr_fn,
                                           int *type_keyval, void *extra_state);
__attribute__((visibility("default"))) int PMPI_Type_create_hindexed_block(int count, int blocklength,
                                                   const MPI_Aint array_of_displacements[],
                                                   MPI_Datatype oldtype,
                                                   MPI_Datatype *newtype);
__attribute__((visibility("default"))) int PMPI_Type_create_indexed_block(int count, int blocklength,
                                                  const int array_of_displacements[],
                                                  MPI_Datatype oldtype,
                                                  MPI_Datatype *newtype);
__attribute__((visibility("default"))) int PMPI_Type_create_struct(int count, const int array_of_block_lengths[],
                                           const MPI_Aint array_of_displacements[],
                                           const MPI_Datatype array_of_types[],
                                           MPI_Datatype *newtype);
__attribute__((visibility("default"))) int PMPI_Type_create_subarray(int ndims, const int size_array[], const int subsize_array[],
                                             const int start_array[], int order,
                                             MPI_Datatype oldtype, MPI_Datatype *newtype);
__attribute__((visibility("default"))) int PMPI_Type_create_resized(MPI_Datatype oldtype, MPI_Aint lb,
                                            MPI_Aint extent, MPI_Datatype *newtype);
__attribute__((visibility("default"))) int PMPI_Type_delete_attr(MPI_Datatype type, int type_keyval);
__attribute__((visibility("default"))) int PMPI_Type_dup(MPI_Datatype type, MPI_Datatype *newtype);
__attribute__((visibility("default"))) int PMPI_Type_extent(MPI_Datatype type, MPI_Aint *extent)
                                    __attribute__((__deprecated__));
__attribute__((visibility("default"))) int PMPI_Type_free(MPI_Datatype *type);
__attribute__((visibility("default"))) int PMPI_Type_free_keyval(int *type_keyval);
__attribute__((visibility("default"))) MPI_Datatype PMPI_Type_f2c(int datatype);
__attribute__((visibility("default"))) int PMPI_Type_get_attr(MPI_Datatype type, int type_keyval,
                                      void *attribute_val, int *flag);
__attribute__((visibility("default"))) int PMPI_Type_get_contents(MPI_Datatype mtype, int max_integers,
                                          int max_addresses, int max_datatypes,
                                          int array_of_integers[],
                                          MPI_Aint array_of_addresses[],
                                          MPI_Datatype array_of_datatypes[]);
__attribute__((visibility("default"))) int PMPI_Type_get_envelope(MPI_Datatype type, int *num_integers,
                                          int *num_addresses, int *num_datatypes,
                                          int *combiner);
__attribute__((visibility("default"))) int PMPI_Type_get_extent(MPI_Datatype type, MPI_Aint *lb,
                                        MPI_Aint *extent);
__attribute__((visibility("default"))) int PMPI_Type_get_extent_x(MPI_Datatype type, MPI_Count *lb,
                                          MPI_Count *extent);
__attribute__((visibility("default"))) int PMPI_Type_get_name(MPI_Datatype type, char *type_name,
                                      int *resultlen);
__attribute__((visibility("default"))) int PMPI_Type_get_true_extent(MPI_Datatype datatype, MPI_Aint *true_lb,
                                             MPI_Aint *true_extent);
__attribute__((visibility("default"))) int PMPI_Type_get_true_extent_x(MPI_Datatype datatype, MPI_Count *true_lb,
                                               MPI_Count *true_extent);
__attribute__((visibility("default"))) int PMPI_Type_hindexed(int count, int array_of_blocklengths[],
                                      MPI_Aint array_of_displacements[],
                                      MPI_Datatype oldtype, MPI_Datatype *newtype)
                                      __attribute__((__deprecated__));
__attribute__((visibility("default"))) int PMPI_Type_hvector(int count, int blocklength, MPI_Aint stride,
                                     MPI_Datatype oldtype, MPI_Datatype *newtype)
                                     __attribute__((__deprecated__));
__attribute__((visibility("default"))) int PMPI_Type_indexed(int count, const int array_of_blocklengths[],
                                     const int array_of_displacements[],
                                     MPI_Datatype oldtype, MPI_Datatype *newtype);
__attribute__((visibility("default"))) int PMPI_Type_lb(MPI_Datatype type, MPI_Aint *lb)
                                __attribute__((__deprecated__));
__attribute__((visibility("default"))) int PMPI_Type_match_size(int typeclass, int size, MPI_Datatype *type);
__attribute__((visibility("default"))) int PMPI_Type_set_attr(MPI_Datatype type, int type_keyval,
                                      void *attr_val);
__attribute__((visibility("default"))) int PMPI_Type_set_name(MPI_Datatype type, const char *type_name);
__attribute__((visibility("default"))) int PMPI_Type_size(MPI_Datatype type, int *size);
__attribute__((visibility("default"))) int PMPI_Type_size_x(MPI_Datatype type, MPI_Count *size);
__attribute__((visibility("default"))) int PMPI_Type_struct(int count, int array_of_blocklengths[],
                                    MPI_Aint array_of_displacements[],
                                    MPI_Datatype array_of_types[],
                                    MPI_Datatype *newtype)
                                    __attribute__((__deprecated__));
__attribute__((visibility("default"))) int PMPI_Type_ub(MPI_Datatype mtype, MPI_Aint *ub)
                                __attribute__((__deprecated__));
__attribute__((visibility("default"))) int PMPI_Type_vector(int count, int blocklength, int stride,
                                    MPI_Datatype oldtype, MPI_Datatype *newtype);
__attribute__((visibility("default"))) int PMPI_Unpack(const void *inbuf, int insize, int *position,
                               void *outbuf, int outcount, MPI_Datatype datatype,
                               MPI_Comm comm);
__attribute__((visibility("default"))) int PMPI_Unpublish_name(const char *service_name, MPI_Info info,
                                       const char *port_name);
__attribute__((visibility("default"))) int PMPI_Unpack_external (const char datarep[], const void *inbuf, MPI_Aint insize,
                                         MPI_Aint *position, void *outbuf, int outcount,
                                         MPI_Datatype datatype);
__attribute__((visibility("default"))) int PMPI_Waitall(int count, MPI_Request array_of_requests[],
                                MPI_Status array_of_statuses[]);
__attribute__((visibility("default"))) int PMPI_Waitany(int count, MPI_Request array_of_requests[],
                                int *index, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_Wait(MPI_Request *request, MPI_Status *status);
__attribute__((visibility("default"))) int PMPI_Waitsome(int incount, MPI_Request array_of_requests[],
                                 int *outcount, int array_of_indices[],
                                 MPI_Status array_of_statuses[]);
__attribute__((visibility("default"))) int PMPI_Win_allocate(MPI_Aint size, int disp_unit, MPI_Info info,
                                     MPI_Comm comm, void *baseptr, MPI_Win *win);
__attribute__((visibility("default"))) int PMPI_Win_allocate_shared(MPI_Aint size, int disp_unit, MPI_Info info,
                                            MPI_Comm comm, void *baseptr, MPI_Win *win);
__attribute__((visibility("default"))) int PMPI_Win_attach(MPI_Win win, void *base, MPI_Aint size);
__attribute__((visibility("default"))) int PMPI_Win_c2f(MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Win_call_errhandler(MPI_Win win, int errorcode);
__attribute__((visibility("default"))) int PMPI_Win_complete(MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Win_create(void *base, MPI_Aint size, int disp_unit,
                                   MPI_Info info, MPI_Comm comm, MPI_Win *win);
__attribute__((visibility("default"))) int PMPI_Win_create_dynamic(MPI_Info info, MPI_Comm comm, MPI_Win *win);
__attribute__((visibility("default"))) int PMPI_Win_create_errhandler(MPI_Win_errhandler_function *function,
                                              MPI_Errhandler *errhandler);
__attribute__((visibility("default"))) int PMPI_Win_create_keyval(MPI_Win_copy_attr_function *win_copy_attr_fn,
                                          MPI_Win_delete_attr_function *win_delete_attr_fn,
                                          int *win_keyval, void *extra_state);
__attribute__((visibility("default"))) int PMPI_Win_delete_attr(MPI_Win win, int win_keyval);
__attribute__((visibility("default"))) int PMPI_Win_detach(MPI_Win win, const void *base);
__attribute__((visibility("default"))) MPI_Win PMPI_Win_f2c(int win);
__attribute__((visibility("default"))) int PMPI_Win_fence(int assert, MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Win_flush(int rank, MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Win_flush_all(MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Win_flush_local(int rank, MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Win_flush_local_all(MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Win_free(MPI_Win *win);
__attribute__((visibility("default"))) int PMPI_Win_free_keyval(int *win_keyval);
__attribute__((visibility("default"))) int PMPI_Win_get_attr(MPI_Win win, int win_keyval,
                                     void *attribute_val, int *flag);
__attribute__((visibility("default"))) int PMPI_Win_get_errhandler(MPI_Win win, MPI_Errhandler *errhandler);
__attribute__((visibility("default"))) int PMPI_Win_get_group(MPI_Win win, MPI_Group *group);
__attribute__((visibility("default"))) int PMPI_Win_get_info(MPI_Win win, MPI_Info *info_used);
__attribute__((visibility("default"))) int PMPI_Win_get_name(MPI_Win win, char *win_name, int *resultlen);
__attribute__((visibility("default"))) int PMPI_Win_lock(int lock_type, int rank, int assert, MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Win_lock_all(int assert, MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Win_post(MPI_Group group, int assert, MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Win_set_attr(MPI_Win win, int win_keyval, void *attribute_val);
__attribute__((visibility("default"))) int PMPI_Win_set_errhandler(MPI_Win win, MPI_Errhandler errhandler);
__attribute__((visibility("default"))) int PMPI_Win_set_info(MPI_Win win, MPI_Info info);
__attribute__((visibility("default"))) int PMPI_Win_set_name(MPI_Win win, const char *win_name);
__attribute__((visibility("default"))) int PMPI_Win_shared_query(MPI_Win win, int rank, MPI_Aint *size, int *disp_unit, void *baseptr);
__attribute__((visibility("default"))) int PMPI_Win_start(MPI_Group group, int assert, MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Win_sync(MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Win_test(MPI_Win win, int *flag);
__attribute__((visibility("default"))) int PMPI_Win_unlock(int rank, MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Win_unlock_all(MPI_Win win);
__attribute__((visibility("default"))) int PMPI_Win_wait(MPI_Win win);
__attribute__((visibility("default"))) double PMPI_Wtick(void);
__attribute__((visibility("default"))) double PMPI_Wtime(void);
__attribute__((visibility("default"))) int PMPI_T_init_thread (int required, int *provided);
__attribute__((visibility("default"))) int PMPI_T_finalize (void);
__attribute__((visibility("default"))) int PMPI_T_cvar_get_num (int *num_cvar);
__attribute__((visibility("default"))) int PMPI_T_cvar_get_info (int cvar_index, char *name, int *name_len,
                                         int *verbosity, MPI_Datatype *datatype,
                                         MPI_T_enum *enumtype, char *desc,
                                         int *desc_len, int *bind, int *scope);
__attribute__((visibility("default"))) int PMPI_T_cvar_get_index (const char *name, int *cvar_index);
__attribute__((visibility("default"))) int PMPI_T_cvar_handle_alloc (int cvar_index, void *obj_handle,
                                            MPI_T_cvar_handle *handle, int *count);
__attribute__((visibility("default"))) int PMPI_T_cvar_handle_free (MPI_T_cvar_handle *handle);
__attribute__((visibility("default"))) int PMPI_T_cvar_read (MPI_T_cvar_handle handle, void *buf);
__attribute__((visibility("default"))) int PMPI_T_cvar_write (MPI_T_cvar_handle handle, const void *buf);
__attribute__((visibility("default"))) int PMPI_T_category_get_num(int *num_cat);
__attribute__((visibility("default"))) int PMPI_T_category_get_info(int cat_index, char *name, int *name_len,
                                            char *desc, int *desc_len, int *num_cvars,
                                            int *num_pvars, int *num_categories);
__attribute__((visibility("default"))) int PMPI_T_category_get_index (const char *name, int *category_index);
__attribute__((visibility("default"))) int PMPI_T_category_get_cvars(int cat_index, int len, int indices[]);
__attribute__((visibility("default"))) int PMPI_T_category_get_pvars(int cat_index, int len, int indices[]);
__attribute__((visibility("default"))) int PMPI_T_category_get_categories(int cat_index, int len, int indices[]);
__attribute__((visibility("default"))) int PMPI_T_category_changed(int *stamp);

__attribute__((visibility("default"))) int PMPI_T_pvar_get_num(int *num_pvar);
__attribute__((visibility("default"))) int PMPI_T_pvar_get_info(int pvar_index, char *name, int *name_len,
                                        int *verbosity, int *var_class, MPI_Datatype *datatype,
                                        MPI_T_enum *enumtype, char *desc, int *desc_len, int *bind,
                                        int *readonly, int *continuous, int *atomic);
__attribute__((visibility("default"))) int PMPI_T_pvar_get_index (const char *name, int var_class, int *pvar_index);
__attribute__((visibility("default"))) int PMPI_T_pvar_session_create(MPI_T_pvar_session *session);
__attribute__((visibility("default"))) int PMPI_T_pvar_session_free(MPI_T_pvar_session *session);
__attribute__((visibility("default"))) int PMPI_T_pvar_handle_alloc(MPI_T_pvar_session session, int pvar_index,
                                            void *obj_handle, MPI_T_pvar_handle *handle, int *count);
__attribute__((visibility("default"))) int PMPI_T_pvar_handle_free(MPI_T_pvar_session session, MPI_T_pvar_handle *handle);
__attribute__((visibility("default"))) int PMPI_T_pvar_start(MPI_T_pvar_session session, MPI_T_pvar_handle handle);
__attribute__((visibility("default"))) int PMPI_T_pvar_stop(MPI_T_pvar_session session, MPI_T_pvar_handle handle);
__attribute__((visibility("default"))) int PMPI_T_pvar_read(MPI_T_pvar_session session, MPI_T_pvar_handle handle,
                                    void *buf);
__attribute__((visibility("default"))) int PMPI_T_pvar_write(MPI_T_pvar_session session, MPI_T_pvar_handle handle,
                                     const void *buf);
__attribute__((visibility("default"))) int PMPI_T_pvar_reset(MPI_T_pvar_session session, MPI_T_pvar_handle handle);
__attribute__((visibility("default"))) int PMPI_T_pvar_readreset(MPI_T_pvar_session session, MPI_T_pvar_handle handle,
                                         void *buf);
__attribute__((visibility("default"))) int PMPI_T_enum_get_info(MPI_T_enum enumtype, int *num, char *name, int *name_len);
__attribute__((visibility("default"))) int PMPI_T_enum_get_item(MPI_T_enum enumtype, int index, int *value, char *name,
                                        int *name_len);




__attribute__((visibility("default"))) int MPI_T_init_thread (int required, int *provided);
__attribute__((visibility("default"))) int MPI_T_finalize (void);
__attribute__((visibility("default"))) int MPI_T_cvar_get_num (int *num_cvar);
__attribute__((visibility("default"))) int MPI_T_cvar_get_info (int cvar_index, char *name, int *name_len,
                                        int *verbosity, MPI_Datatype *datatype,
                                        MPI_T_enum *enumtype, char *desc,
                                        int *desc_len, int *bind, int *scope);
__attribute__((visibility("default"))) int MPI_T_cvar_get_index (const char *name, int *cvar_index);
__attribute__((visibility("default"))) int MPI_T_cvar_handle_alloc (int cvar_index, void *obj_handle,
                                            MPI_T_cvar_handle *handle, int *count);
__attribute__((visibility("default"))) int MPI_T_cvar_handle_free (MPI_T_cvar_handle *handle);
__attribute__((visibility("default"))) int MPI_T_cvar_read (MPI_T_cvar_handle handle, void *buf);
__attribute__((visibility("default"))) int MPI_T_cvar_write (MPI_T_cvar_handle handle, const void *buf);
__attribute__((visibility("default"))) int MPI_T_category_get_num(int *num_cat);
__attribute__((visibility("default"))) int MPI_T_category_get_info(int cat_index, char *name, int *name_len,
                                           char *desc, int *desc_len, int *num_cvars,
                                           int *num_pvars, int *num_categories);
__attribute__((visibility("default"))) int MPI_T_category_get_index (const char *name, int *category_index);
__attribute__((visibility("default"))) int MPI_T_category_get_cvars(int cat_index, int len, int indices[]);
__attribute__((visibility("default"))) int MPI_T_category_get_pvars(int cat_index, int len, int indices[]);
__attribute__((visibility("default"))) int MPI_T_category_get_categories(int cat_index, int len, int indices[]);
__attribute__((visibility("default"))) int MPI_T_category_changed(int *stamp);

__attribute__((visibility("default"))) int MPI_T_pvar_get_num(int *num_pvar);
__attribute__((visibility("default"))) int MPI_T_pvar_get_info(int pvar_index, char *name, int *name_len,
                                       int *verbosity, int *var_class, MPI_Datatype *datatype,
                                       MPI_T_enum *enumtype, char *desc, int *desc_len, int *bind,
                                       int *readonly, int *continuous, int *atomic);
__attribute__((visibility("default"))) int MPI_T_pvar_get_index (const char *name, int var_class, int *pvar_index);
__attribute__((visibility("default"))) int MPI_T_pvar_session_create(MPI_T_pvar_session *session);
__attribute__((visibility("default"))) int MPI_T_pvar_session_free(MPI_T_pvar_session *session);
__attribute__((visibility("default"))) int MPI_T_pvar_handle_alloc(MPI_T_pvar_session session, int pvar_index,
                                           void *obj_handle, MPI_T_pvar_handle *handle, int *count);
__attribute__((visibility("default"))) int MPI_T_pvar_handle_free(MPI_T_pvar_session session, MPI_T_pvar_handle *handle);
__attribute__((visibility("default"))) int MPI_T_pvar_start(MPI_T_pvar_session session, MPI_T_pvar_handle handle);
__attribute__((visibility("default"))) int MPI_T_pvar_stop(MPI_T_pvar_session session, MPI_T_pvar_handle handle);
__attribute__((visibility("default"))) int MPI_T_pvar_read(MPI_T_pvar_session session, MPI_T_pvar_handle handle,
                                   void *buf);
__attribute__((visibility("default"))) int MPI_T_pvar_write(MPI_T_pvar_session session, MPI_T_pvar_handle handle,
                                    const void *buf);
__attribute__((visibility("default"))) int MPI_T_pvar_reset(MPI_T_pvar_session session, MPI_T_pvar_handle handle);
__attribute__((visibility("default"))) int MPI_T_pvar_readreset(MPI_T_pvar_session session, MPI_T_pvar_handle handle,
                                        void *buf);
__attribute__((visibility("default"))) int MPI_T_enum_get_info(MPI_T_enum enumtype, int *num, char *name, int *name_len);
__attribute__((visibility("default"))) int MPI_T_enum_get_item(MPI_T_enum enumtype, int index, int *value, char *name,
                                       int *name_len);
# 5 "src/parallelSplitMPI.h" 2

# 1 "src/communDef.h" 1
# 1 "/usr/include/stdio.h" 1 3 4
# 28 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/features.h" 1 3 4
# 329 "/usr/include/features.h" 3 4
# 1 "/usr/include/sys/cdefs.h" 1 3 4
# 313 "/usr/include/sys/cdefs.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 314 "/usr/include/sys/cdefs.h" 2 3 4
# 330 "/usr/include/features.h" 2 3 4
# 352 "/usr/include/features.h" 3 4
# 1 "/usr/include/gnu/stubs.h" 1 3 4



# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 5 "/usr/include/gnu/stubs.h" 2 3 4


# 1 "/usr/include/gnu/stubs-32.h" 1 3 4
# 8 "/usr/include/gnu/stubs.h" 2 3 4
# 353 "/usr/include/features.h" 2 3 4
# 29 "/usr/include/stdio.h" 2 3 4





# 1 "/usr/lib/gcc/i386-redhat-linux/4.1.2/include/stddef.h" 1 3 4
# 35 "/usr/include/stdio.h" 2 3 4

# 1 "/usr/include/bits/types.h" 1 3 4
# 28 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 29 "/usr/include/bits/types.h" 2 3 4


# 1 "/usr/lib/gcc/i386-redhat-linux/4.1.2/include/stddef.h" 1 3 4
# 32 "/usr/include/bits/types.h" 2 3 4


typedef unsigned char __u_char;
typedef unsigned short int __u_short;
typedef unsigned int __u_int;
typedef unsigned long int __u_long;


typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef signed short int __int16_t;
typedef unsigned short int __uint16_t;
typedef signed int __int32_t;
typedef unsigned int __uint32_t;




__extension__ typedef signed long long int __int64_t;
__extension__ typedef unsigned long long int __uint64_t;







__extension__ typedef long long int __quad_t;
__extension__ typedef unsigned long long int __u_quad_t;
# 134 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/typesizes.h" 1 3 4
# 135 "/usr/include/bits/types.h" 2 3 4


__extension__ typedef __u_quad_t __dev_t;
__extension__ typedef unsigned int __uid_t;
__extension__ typedef unsigned int __gid_t;
__extension__ typedef unsigned long int __ino_t;
__extension__ typedef __u_quad_t __ino64_t;
__extension__ typedef unsigned int __mode_t;
__extension__ typedef unsigned int __nlink_t;
__extension__ typedef long int __off_t;
__extension__ typedef __quad_t __off64_t;
__extension__ typedef int __pid_t;
__extension__ typedef struct { int __val[2]; } __fsid_t;
__extension__ typedef long int __clock_t;
__extension__ typedef unsigned long int __rlim_t;
__extension__ typedef __u_quad_t __rlim64_t;
__extension__ typedef unsigned int __id_t;
__extension__ typedef long int __time_t;
__extension__ typedef unsigned int __useconds_t;
__extension__ typedef long int __suseconds_t;

__extension__ typedef int __daddr_t;
__extension__ typedef long int __swblk_t;
__extension__ typedef int __key_t;


__extension__ typedef int __clockid_t;


__extension__ typedef void * __timer_t;


__extension__ typedef long int __blksize_t;




__extension__ typedef long int __blkcnt_t;
__extension__ typedef __quad_t __blkcnt64_t;


__extension__ typedef unsigned long int __fsblkcnt_t;
__extension__ typedef __u_quad_t __fsblkcnt64_t;


__extension__ typedef unsigned long int __fsfilcnt_t;
__extension__ typedef __u_quad_t __fsfilcnt64_t;

__extension__ typedef int __ssize_t;



typedef __off64_t __loff_t;
typedef __quad_t *__qaddr_t;
typedef char *__caddr_t;


__extension__ typedef int __intptr_t;


__extension__ typedef unsigned int __socklen_t;
# 37 "/usr/include/stdio.h" 2 3 4









typedef struct _IO_FILE FILE;





# 62 "/usr/include/stdio.h" 3 4
typedef struct _IO_FILE __FILE;
# 72 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/libio.h" 1 3 4
# 32 "/usr/include/libio.h" 3 4
# 1 "/usr/include/_G_config.h" 1 3 4
# 14 "/usr/include/_G_config.h" 3 4
# 1 "/usr/lib/gcc/i386-redhat-linux/4.1.2/include/stddef.h" 1 3 4
# 355 "/usr/lib/gcc/i386-redhat-linux/4.1.2/include/stddef.h" 3 4
typedef unsigned int wint_t;
# 15 "/usr/include/_G_config.h" 2 3 4
# 24 "/usr/include/_G_config.h" 3 4
# 1 "/usr/include/wchar.h" 1 3 4
# 48 "/usr/include/wchar.h" 3 4
# 1 "/usr/lib/gcc/i386-redhat-linux/4.1.2/include/stddef.h" 1 3 4
# 49 "/usr/include/wchar.h" 2 3 4

# 1 "/usr/include/bits/wchar.h" 1 3 4
# 51 "/usr/include/wchar.h" 2 3 4
# 76 "/usr/include/wchar.h" 3 4
typedef struct
{
  int __count;
  union
  {
    wint_t __wch;
    char __wchb[4];
  } __value;
} __mbstate_t;
# 25 "/usr/include/_G_config.h" 2 3 4

typedef struct
{
  __off_t __pos;
  __mbstate_t __state;
} _G_fpos_t;
typedef struct
{
  __off64_t __pos;
  __mbstate_t __state;
} _G_fpos64_t;
# 44 "/usr/include/_G_config.h" 3 4
# 1 "/usr/include/gconv.h" 1 3 4
# 28 "/usr/include/gconv.h" 3 4
# 1 "/usr/include/wchar.h" 1 3 4
# 48 "/usr/include/wchar.h" 3 4
# 1 "/usr/lib/gcc/i386-redhat-linux/4.1.2/include/stddef.h" 1 3 4
# 49 "/usr/include/wchar.h" 2 3 4
# 29 "/usr/include/gconv.h" 2 3 4


# 1 "/usr/lib/gcc/i386-redhat-linux/4.1.2/include/stddef.h" 1 3 4
# 32 "/usr/include/gconv.h" 2 3 4





enum
{
  __GCONV_OK = 0,
  __GCONV_NOCONV,
  __GCONV_NODB,
  __GCONV_NOMEM,

  __GCONV_EMPTY_INPUT,
  __GCONV_FULL_OUTPUT,
  __GCONV_ILLEGAL_INPUT,
  __GCONV_INCOMPLETE_INPUT,

  __GCONV_ILLEGAL_DESCRIPTOR,
  __GCONV_INTERNAL_ERROR
};



enum
{
  __GCONV_IS_LAST = 0x0001,
  __GCONV_IGNORE_ERRORS = 0x0002
};



struct __gconv_step;
struct __gconv_step_data;
struct __gconv_loaded_object;
struct __gconv_trans_data;



typedef int (*__gconv_fct) (struct __gconv_step *, struct __gconv_step_data *,
       __const unsigned char **, __const unsigned char *,
       unsigned char **, size_t *, int, int);


typedef wint_t (*__gconv_btowc_fct) (struct __gconv_step *, unsigned char);


typedef int (*__gconv_init_fct) (struct __gconv_step *);
typedef void (*__gconv_end_fct) (struct __gconv_step *);



typedef int (*__gconv_trans_fct) (struct __gconv_step *,
      struct __gconv_step_data *, void *,
      __const unsigned char *,
      __const unsigned char **,
      __const unsigned char *, unsigned char **,
      size_t *);


typedef int (*__gconv_trans_context_fct) (void *, __const unsigned char *,
       __const unsigned char *,
       unsigned char *, unsigned char *);


typedef int (*__gconv_trans_query_fct) (__const char *, __const char ***,
     size_t *);


typedef int (*__gconv_trans_init_fct) (void **, const char *);
typedef void (*__gconv_trans_end_fct) (void *);

struct __gconv_trans_data
{

  __gconv_trans_fct __trans_fct;
  __gconv_trans_context_fct __trans_context_fct;
  __gconv_trans_end_fct __trans_end_fct;
  void *__data;
  struct __gconv_trans_data *__next;
};



struct __gconv_step
{
  struct __gconv_loaded_object *__shlib_handle;
  __const char *__modname;

  int __counter;

  char *__from_name;
  char *__to_name;

  __gconv_fct __fct;
  __gconv_btowc_fct __btowc_fct;
  __gconv_init_fct __init_fct;
  __gconv_end_fct __end_fct;



  int __min_needed_from;
  int __max_needed_from;
  int __min_needed_to;
  int __max_needed_to;


  int __stateful;

  void *__data;
};



struct __gconv_step_data
{
  unsigned char *__outbuf;
  unsigned char *__outbufend;



  int __flags;



  int __invocation_counter;



  int __internal_use;

  __mbstate_t *__statep;
  __mbstate_t __state;



  struct __gconv_trans_data *__trans;
};



typedef struct __gconv_info
{
  size_t __nsteps;
  struct __gconv_step *__steps;
  __extension__ struct __gconv_step_data __data [];
} *__gconv_t;
# 45 "/usr/include/_G_config.h" 2 3 4
typedef union
{
  struct __gconv_info __cd;
  struct
  {
    struct __gconv_info __cd;
    struct __gconv_step_data __data;
  } __combined;
} _G_iconv_t;

typedef int _G_int16_t __attribute__ ((__mode__ (__HI__)));
typedef int _G_int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int _G_uint16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int _G_uint32_t __attribute__ ((__mode__ (__SI__)));
# 33 "/usr/include/libio.h" 2 3 4
# 53 "/usr/include/libio.h" 3 4
# 1 "/usr/lib/gcc/i386-redhat-linux/4.1.2/include/stdarg.h" 1 3 4
# 43 "/usr/lib/gcc/i386-redhat-linux/4.1.2/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 54 "/usr/include/libio.h" 2 3 4
# 167 "/usr/include/libio.h" 3 4
struct _IO_jump_t; struct _IO_FILE;
# 177 "/usr/include/libio.h" 3 4
typedef void _IO_lock_t;





struct _IO_marker {
  struct _IO_marker *_next;
  struct _IO_FILE *_sbuf;



  int _pos;
# 200 "/usr/include/libio.h" 3 4
};


enum __codecvt_result
{
  __codecvt_ok,
  __codecvt_partial,
  __codecvt_error,
  __codecvt_noconv
};
# 268 "/usr/include/libio.h" 3 4
struct _IO_FILE {
  int _flags;




  char* _IO_read_ptr;
  char* _IO_read_end;
  char* _IO_read_base;
  char* _IO_write_base;
  char* _IO_write_ptr;
  char* _IO_write_end;
  char* _IO_buf_base;
  char* _IO_buf_end;

  char *_IO_save_base;
  char *_IO_backup_base;
  char *_IO_save_end;

  struct _IO_marker *_markers;

  struct _IO_FILE *_chain;

  int _fileno;



  int _flags2;

  __off_t _old_offset;



  unsigned short _cur_column;
  signed char _vtable_offset;
  char _shortbuf[1];



  _IO_lock_t *_lock;
# 316 "/usr/include/libio.h" 3 4
  __off64_t _offset;
# 325 "/usr/include/libio.h" 3 4
  void *__pad1;
  void *__pad2;
  void *__pad3;
  void *__pad4;
  size_t __pad5;

  int _mode;

  char _unused2[15 * sizeof (int) - 4 * sizeof (void *) - sizeof (size_t)];

};


typedef struct _IO_FILE _IO_FILE;


struct _IO_FILE_plus;

extern struct _IO_FILE_plus _IO_2_1_stdin_;
extern struct _IO_FILE_plus _IO_2_1_stdout_;
extern struct _IO_FILE_plus _IO_2_1_stderr_;
# 361 "/usr/include/libio.h" 3 4
typedef __ssize_t __io_read_fn (void *__cookie, char *__buf, size_t __nbytes);







typedef __ssize_t __io_write_fn (void *__cookie, __const char *__buf,
     size_t __n);







typedef int __io_seek_fn (void *__cookie, __off64_t *__pos, int __w);


typedef int __io_close_fn (void *__cookie);
# 413 "/usr/include/libio.h" 3 4
extern int __underflow (_IO_FILE *);
extern int __uflow (_IO_FILE *);
extern int __overflow (_IO_FILE *, int);
extern wint_t __wunderflow (_IO_FILE *);
extern wint_t __wuflow (_IO_FILE *);
extern wint_t __woverflow (_IO_FILE *, wint_t);
# 451 "/usr/include/libio.h" 3 4
extern int _IO_getc (_IO_FILE *__fp);
extern int _IO_putc (int __c, _IO_FILE *__fp);
extern int _IO_feof (_IO_FILE *__fp) __attribute__ ((__nothrow__));
extern int _IO_ferror (_IO_FILE *__fp) __attribute__ ((__nothrow__));

extern int _IO_peekc_locked (_IO_FILE *__fp);





extern void _IO_flockfile (_IO_FILE *) __attribute__ ((__nothrow__));
extern void _IO_funlockfile (_IO_FILE *) __attribute__ ((__nothrow__));
extern int _IO_ftrylockfile (_IO_FILE *) __attribute__ ((__nothrow__));
# 481 "/usr/include/libio.h" 3 4
extern int _IO_vfscanf (_IO_FILE * __restrict, const char * __restrict,
   __gnuc_va_list, int *__restrict);
extern int _IO_vfprintf (_IO_FILE *__restrict, const char *__restrict,
    __gnuc_va_list);
extern __ssize_t _IO_padn (_IO_FILE *, int, __ssize_t);
extern size_t _IO_sgetn (_IO_FILE *, void *, size_t);

extern __off64_t _IO_seekoff (_IO_FILE *, __off64_t, int, int);
extern __off64_t _IO_seekpos (_IO_FILE *, __off64_t, int);

extern void _IO_free_backup_area (_IO_FILE *) __attribute__ ((__nothrow__));
# 73 "/usr/include/stdio.h" 2 3 4
# 86 "/usr/include/stdio.h" 3 4


typedef _G_fpos_t fpos_t;




# 138 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/bits/stdio_lim.h" 1 3 4
# 139 "/usr/include/stdio.h" 2 3 4



extern struct _IO_FILE *stdin;
extern struct _IO_FILE *stdout;
extern struct _IO_FILE *stderr;









extern int remove (__const char *__filename) __attribute__ ((__nothrow__));

extern int rename (__const char *__old, __const char *__new) __attribute__ ((__nothrow__));














extern FILE *tmpfile (void);
# 185 "/usr/include/stdio.h" 3 4
extern char *tmpnam (char *__s) __attribute__ ((__nothrow__));





extern char *tmpnam_r (char *__s) __attribute__ ((__nothrow__));
# 203 "/usr/include/stdio.h" 3 4
extern char *tempnam (__const char *__dir, __const char *__pfx)
     __attribute__ ((__nothrow__)) __attribute__ ((__malloc__));








extern int fclose (FILE *__stream);




extern int fflush (FILE *__stream);

# 228 "/usr/include/stdio.h" 3 4
extern int fflush_unlocked (FILE *__stream);
# 242 "/usr/include/stdio.h" 3 4






extern FILE *fopen (__const char *__restrict __filename,
      __const char *__restrict __modes);




extern FILE *freopen (__const char *__restrict __filename,
        __const char *__restrict __modes,
        FILE *__restrict __stream);
# 269 "/usr/include/stdio.h" 3 4

# 280 "/usr/include/stdio.h" 3 4
extern FILE *fdopen (int __fd, __const char *__modes) __attribute__ ((__nothrow__));
# 300 "/usr/include/stdio.h" 3 4



extern void setbuf (FILE *__restrict __stream, char *__restrict __buf) __attribute__ ((__nothrow__));



extern int setvbuf (FILE *__restrict __stream, char *__restrict __buf,
      int __modes, size_t __n) __attribute__ ((__nothrow__));





extern void setbuffer (FILE *__restrict __stream, char *__restrict __buf,
         size_t __size) __attribute__ ((__nothrow__));


extern void setlinebuf (FILE *__stream) __attribute__ ((__nothrow__));








extern int fprintf (FILE *__restrict __stream,
      __const char *__restrict __format, ...);




extern int printf (__const char *__restrict __format, ...);

extern int sprintf (char *__restrict __s,
      __const char *__restrict __format, ...) __attribute__ ((__nothrow__));





extern int vfprintf (FILE *__restrict __s, __const char *__restrict __format,
       __gnuc_va_list __arg);




extern int vprintf (__const char *__restrict __format, __gnuc_va_list __arg);

extern int vsprintf (char *__restrict __s, __const char *__restrict __format,
       __gnuc_va_list __arg) __attribute__ ((__nothrow__));





extern int snprintf (char *__restrict __s, size_t __maxlen,
       __const char *__restrict __format, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 4)));

extern int vsnprintf (char *__restrict __s, size_t __maxlen,
        __const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 0)));

# 394 "/usr/include/stdio.h" 3 4





extern int fscanf (FILE *__restrict __stream,
     __const char *__restrict __format, ...) ;




extern int scanf (__const char *__restrict __format, ...) ;

extern int sscanf (__const char *__restrict __s,
     __const char *__restrict __format, ...) __attribute__ ((__nothrow__));

# 436 "/usr/include/stdio.h" 3 4





extern int fgetc (FILE *__stream);
extern int getc (FILE *__stream);





extern int getchar (void);

# 460 "/usr/include/stdio.h" 3 4
extern int getc_unlocked (FILE *__stream);
extern int getchar_unlocked (void);
# 471 "/usr/include/stdio.h" 3 4
extern int fgetc_unlocked (FILE *__stream);











extern int fputc (int __c, FILE *__stream);
extern int putc (int __c, FILE *__stream);





extern int putchar (int __c);

# 504 "/usr/include/stdio.h" 3 4
extern int fputc_unlocked (int __c, FILE *__stream);







extern int putc_unlocked (int __c, FILE *__stream);
extern int putchar_unlocked (int __c);






extern int getw (FILE *__stream);


extern int putw (int __w, FILE *__stream);








extern char *fgets (char *__restrict __s, int __n, FILE *__restrict __stream)
     ;






extern char *gets (char *__s) ;

# 585 "/usr/include/stdio.h" 3 4





extern int fputs (__const char *__restrict __s, FILE *__restrict __stream);





extern int puts (__const char *__s);






extern int ungetc (int __c, FILE *__stream);






extern size_t fread (void *__restrict __ptr, size_t __size,
       size_t __n, FILE *__restrict __stream) ;




extern size_t fwrite (__const void *__restrict __ptr, size_t __size,
        size_t __n, FILE *__restrict __s) ;

# 638 "/usr/include/stdio.h" 3 4
extern size_t fread_unlocked (void *__restrict __ptr, size_t __size,
         size_t __n, FILE *__restrict __stream) ;
extern size_t fwrite_unlocked (__const void *__restrict __ptr, size_t __size,
          size_t __n, FILE *__restrict __stream) ;








extern int fseek (FILE *__stream, long int __off, int __whence);




extern long int ftell (FILE *__stream) ;




extern void rewind (FILE *__stream);

# 674 "/usr/include/stdio.h" 3 4
extern int fseeko (FILE *__stream, __off_t __off, int __whence);




extern __off_t ftello (FILE *__stream) ;
# 693 "/usr/include/stdio.h" 3 4






extern int fgetpos (FILE *__restrict __stream, fpos_t *__restrict __pos);




extern int fsetpos (FILE *__stream, __const fpos_t *__pos);
# 716 "/usr/include/stdio.h" 3 4

# 725 "/usr/include/stdio.h" 3 4


extern void clearerr (FILE *__stream) __attribute__ ((__nothrow__));

extern int feof (FILE *__stream) __attribute__ ((__nothrow__)) ;

extern int ferror (FILE *__stream) __attribute__ ((__nothrow__)) ;




extern void clearerr_unlocked (FILE *__stream) __attribute__ ((__nothrow__));
extern int feof_unlocked (FILE *__stream) __attribute__ ((__nothrow__)) ;
extern int ferror_unlocked (FILE *__stream) __attribute__ ((__nothrow__)) ;








extern void perror (__const char *__s);






# 1 "/usr/include/bits/sys_errlist.h" 1 3 4
# 27 "/usr/include/bits/sys_errlist.h" 3 4
extern int sys_nerr;
extern __const char *__const sys_errlist[];
# 755 "/usr/include/stdio.h" 2 3 4




extern int fileno (FILE *__stream) __attribute__ ((__nothrow__)) ;




extern int fileno_unlocked (FILE *__stream) __attribute__ ((__nothrow__)) ;
# 774 "/usr/include/stdio.h" 3 4
extern FILE *popen (__const char *__command, __const char *__modes) ;





extern int pclose (FILE *__stream);





extern char *ctermid (char *__s) __attribute__ ((__nothrow__));
# 814 "/usr/include/stdio.h" 3 4
extern void flockfile (FILE *__stream) __attribute__ ((__nothrow__));



extern int ftrylockfile (FILE *__stream) __attribute__ ((__nothrow__)) ;


extern void funlockfile (FILE *__stream) __attribute__ ((__nothrow__));
# 835 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/bits/stdio.h" 1 3 4
# 33 "/usr/include/bits/stdio.h" 3 4
extern __inline int
vprintf (__const char *__restrict __fmt, __gnuc_va_list __arg)
{
  return vfprintf (stdout, __fmt, __arg);
}


extern __inline int
getchar (void)
{
  return _IO_getc (stdin);
}




extern __inline int
fgetc_unlocked (FILE *__fp)
{
  return (__builtin_expect (((__fp)->_IO_read_ptr >= (__fp)->_IO_read_end), 0) ? __uflow (__fp) : *(unsigned char *) (__fp)->_IO_read_ptr++);
}





extern __inline int
getc_unlocked (FILE *__fp)
{
  return (__builtin_expect (((__fp)->_IO_read_ptr >= (__fp)->_IO_read_end), 0) ? __uflow (__fp) : *(unsigned char *) (__fp)->_IO_read_ptr++);
}


extern __inline int
getchar_unlocked (void)
{
  return (__builtin_expect (((stdin)->_IO_read_ptr >= (stdin)->_IO_read_end), 0) ? __uflow (stdin) : *(unsigned char *) (stdin)->_IO_read_ptr++);
}




extern __inline int
putchar (int __c)
{
  return _IO_putc (__c, stdout);
}




extern __inline int
fputc_unlocked (int __c, FILE *__stream)
{
  return (__builtin_expect (((__stream)->_IO_write_ptr >= (__stream)->_IO_write_end), 0) ? __overflow (__stream, (unsigned char) (__c)) : (unsigned char) (*(__stream)->_IO_write_ptr++ = (__c)));
}





extern __inline int
putc_unlocked (int __c, FILE *__stream)
{
  return (__builtin_expect (((__stream)->_IO_write_ptr >= (__stream)->_IO_write_end), 0) ? __overflow (__stream, (unsigned char) (__c)) : (unsigned char) (*(__stream)->_IO_write_ptr++ = (__c)));
}


extern __inline int
putchar_unlocked (int __c)
{
  return (__builtin_expect (((stdout)->_IO_write_ptr >= (stdout)->_IO_write_end), 0) ? __overflow (stdout, (unsigned char) (__c)) : (unsigned char) (*(stdout)->_IO_write_ptr++ = (__c)));
}
# 121 "/usr/include/bits/stdio.h" 3 4
extern __inline int
__attribute__ ((__nothrow__)) feof_unlocked (FILE *__stream)
{
  return (((__stream)->_flags & 0x10) != 0);
}


extern __inline int
__attribute__ ((__nothrow__)) ferror_unlocked (FILE *__stream)
{
  return (((__stream)->_flags & 0x20) != 0);
}
# 836 "/usr/include/stdio.h" 2 3 4
# 844 "/usr/include/stdio.h" 3 4

# 2 "src/communDef.h" 2
# 1 "/usr/include/stdlib.h" 1 3 4
# 33 "/usr/include/stdlib.h" 3 4
# 1 "/usr/lib/gcc/i386-redhat-linux/4.1.2/include/stddef.h" 1 3 4
# 34 "/usr/include/stdlib.h" 2 3 4


# 96 "/usr/include/stdlib.h" 3 4


typedef struct
  {
    int quot;
    int rem;
  } div_t;



typedef struct
  {
    long int quot;
    long int rem;
  } ldiv_t;



# 140 "/usr/include/stdlib.h" 3 4
extern size_t __ctype_get_mb_cur_max (void) __attribute__ ((__nothrow__)) ;




extern double atof (__const char *__nptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;

extern int atoi (__const char *__nptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;

extern long int atol (__const char *__nptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;





__extension__ extern long long int atoll (__const char *__nptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;





extern double strtod (__const char *__restrict __nptr,
        char **__restrict __endptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;

# 182 "/usr/include/stdlib.h" 3 4


extern long int strtol (__const char *__restrict __nptr,
   char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;

extern unsigned long int strtoul (__const char *__restrict __nptr,
      char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;




__extension__
extern long long int strtoq (__const char *__restrict __nptr,
        char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;

__extension__
extern unsigned long long int strtouq (__const char *__restrict __nptr,
           char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;





__extension__
extern long long int strtoll (__const char *__restrict __nptr,
         char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;

__extension__
extern unsigned long long int strtoull (__const char *__restrict __nptr,
     char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;

# 279 "/usr/include/stdlib.h" 3 4
extern double __strtod_internal (__const char *__restrict __nptr,
     char **__restrict __endptr, int __group)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;
extern float __strtof_internal (__const char *__restrict __nptr,
    char **__restrict __endptr, int __group)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;
extern long double __strtold_internal (__const char *__restrict __nptr,
           char **__restrict __endptr,
           int __group)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;

extern long int __strtol_internal (__const char *__restrict __nptr,
       char **__restrict __endptr,
       int __base, int __group)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;



extern unsigned long int __strtoul_internal (__const char *__restrict __nptr,
          char **__restrict __endptr,
          int __base, int __group)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;




__extension__
extern long long int __strtoll_internal (__const char *__restrict __nptr,
      char **__restrict __endptr,
      int __base, int __group)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;



__extension__
extern unsigned long long int __strtoull_internal (__const char *
         __restrict __nptr,
         char **__restrict __endptr,
         int __base, int __group)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;








extern __inline double
__attribute__ ((__nothrow__)) strtod (__const char *__restrict __nptr, char **__restrict __endptr)
{
  return __strtod_internal (__nptr, __endptr, 0);
}
extern __inline long int
__attribute__ ((__nothrow__)) strtol (__const char *__restrict __nptr, char **__restrict __endptr, int __base)

{
  return __strtol_internal (__nptr, __endptr, __base, 0);
}
extern __inline unsigned long int
__attribute__ ((__nothrow__)) strtoul (__const char *__restrict __nptr, char **__restrict __endptr, int __base)

{
  return __strtoul_internal (__nptr, __endptr, __base, 0);
}

# 364 "/usr/include/stdlib.h" 3 4
__extension__ extern __inline long long int
__attribute__ ((__nothrow__)) strtoq (__const char *__restrict __nptr, char **__restrict __endptr, int __base)

{
  return __strtoll_internal (__nptr, __endptr, __base, 0);
}
__extension__ extern __inline unsigned long long int
__attribute__ ((__nothrow__)) strtouq (__const char *__restrict __nptr, char **__restrict __endptr, int __base)

{
  return __strtoull_internal (__nptr, __endptr, __base, 0);
}




__extension__ extern __inline long long int
__attribute__ ((__nothrow__)) strtoll (__const char *__restrict __nptr, char **__restrict __endptr, int __base)

{
  return __strtoll_internal (__nptr, __endptr, __base, 0);
}
__extension__ extern __inline unsigned long long int
__attribute__ ((__nothrow__)) strtoull (__const char * __restrict __nptr, char **__restrict __endptr, int __base)

{
  return __strtoull_internal (__nptr, __endptr, __base, 0);
}




extern __inline double
__attribute__ ((__nothrow__)) atof (__const char *__nptr)
{
  return strtod (__nptr, (char **) ((void *)0));
}
extern __inline int
__attribute__ ((__nothrow__)) atoi (__const char *__nptr)
{
  return (int) strtol (__nptr, (char **) ((void *)0), 10);
}
extern __inline long int
__attribute__ ((__nothrow__)) atol (__const char *__nptr)
{
  return strtol (__nptr, (char **) ((void *)0), 10);
}




__extension__ extern __inline long long int
__attribute__ ((__nothrow__)) atoll (__const char *__nptr)
{
  return strtoll (__nptr, (char **) ((void *)0), 10);
}

# 429 "/usr/include/stdlib.h" 3 4
extern char *l64a (long int __n) __attribute__ ((__nothrow__)) ;


extern long int a64l (__const char *__s)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;




# 1 "/usr/include/sys/types.h" 1 3 4
# 29 "/usr/include/sys/types.h" 3 4






typedef __u_char u_char;
typedef __u_short u_short;
typedef __u_int u_int;
typedef __u_long u_long;
typedef __quad_t quad_t;
typedef __u_quad_t u_quad_t;
typedef __fsid_t fsid_t;




typedef __loff_t loff_t;



typedef __ino_t ino_t;
# 62 "/usr/include/sys/types.h" 3 4
typedef __dev_t dev_t;




typedef __gid_t gid_t;




typedef __mode_t mode_t;




typedef __nlink_t nlink_t;




typedef __uid_t uid_t;





typedef __off_t off_t;
# 100 "/usr/include/sys/types.h" 3 4
typedef __pid_t pid_t;




typedef __id_t id_t;




typedef __ssize_t ssize_t;





typedef __daddr_t daddr_t;
typedef __caddr_t caddr_t;





typedef __key_t key_t;
# 133 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/time.h" 1 3 4
# 75 "/usr/include/time.h" 3 4


typedef __time_t time_t;



# 93 "/usr/include/time.h" 3 4
typedef __clockid_t clockid_t;
# 105 "/usr/include/time.h" 3 4
typedef __timer_t timer_t;
# 134 "/usr/include/sys/types.h" 2 3 4
# 147 "/usr/include/sys/types.h" 3 4
# 1 "/usr/lib/gcc/i386-redhat-linux/4.1.2/include/stddef.h" 1 3 4
# 148 "/usr/include/sys/types.h" 2 3 4



typedef unsigned long int ulong;
typedef unsigned short int ushort;
typedef unsigned int uint;
# 195 "/usr/include/sys/types.h" 3 4
typedef int int8_t __attribute__ ((__mode__ (__QI__)));
typedef int int16_t __attribute__ ((__mode__ (__HI__)));
typedef int int32_t __attribute__ ((__mode__ (__SI__)));
typedef int int64_t __attribute__ ((__mode__ (__DI__)));


typedef unsigned int u_int8_t __attribute__ ((__mode__ (__QI__)));
typedef unsigned int u_int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int u_int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int u_int64_t __attribute__ ((__mode__ (__DI__)));

typedef int register_t __attribute__ ((__mode__ (__word__)));
# 217 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/endian.h" 1 3 4
# 37 "/usr/include/endian.h" 3 4
# 1 "/usr/include/bits/endian.h" 1 3 4
# 38 "/usr/include/endian.h" 2 3 4
# 218 "/usr/include/sys/types.h" 2 3 4


# 1 "/usr/include/sys/select.h" 1 3 4
# 31 "/usr/include/sys/select.h" 3 4
# 1 "/usr/include/bits/select.h" 1 3 4
# 32 "/usr/include/sys/select.h" 2 3 4


# 1 "/usr/include/bits/sigset.h" 1 3 4
# 23 "/usr/include/bits/sigset.h" 3 4
typedef int __sig_atomic_t;




typedef struct
  {
    unsigned long int __val[(1024 / (8 * sizeof (unsigned long int)))];
  } __sigset_t;
# 35 "/usr/include/sys/select.h" 2 3 4



typedef __sigset_t sigset_t;





# 1 "/usr/include/time.h" 1 3 4
# 121 "/usr/include/time.h" 3 4
struct timespec
  {
    __time_t tv_sec;
    long int tv_nsec;
  };
# 45 "/usr/include/sys/select.h" 2 3 4

# 1 "/usr/include/bits/time.h" 1 3 4
# 69 "/usr/include/bits/time.h" 3 4
struct timeval
  {
    __time_t tv_sec;
    __suseconds_t tv_usec;
  };
# 47 "/usr/include/sys/select.h" 2 3 4


typedef __suseconds_t suseconds_t;





typedef long int __fd_mask;
# 67 "/usr/include/sys/select.h" 3 4
typedef struct
  {






    __fd_mask __fds_bits[1024 / (8 * sizeof (__fd_mask))];


  } fd_set;






typedef __fd_mask fd_mask;
# 99 "/usr/include/sys/select.h" 3 4

# 109 "/usr/include/sys/select.h" 3 4
extern int select (int __nfds, fd_set *__restrict __readfds,
     fd_set *__restrict __writefds,
     fd_set *__restrict __exceptfds,
     struct timeval *__restrict __timeout);
# 121 "/usr/include/sys/select.h" 3 4
extern int pselect (int __nfds, fd_set *__restrict __readfds,
      fd_set *__restrict __writefds,
      fd_set *__restrict __exceptfds,
      const struct timespec *__restrict __timeout,
      const __sigset_t *__restrict __sigmask);



# 221 "/usr/include/sys/types.h" 2 3 4


# 1 "/usr/include/sys/sysmacros.h" 1 3 4
# 29 "/usr/include/sys/sysmacros.h" 3 4
__extension__
extern __inline unsigned int gnu_dev_major (unsigned long long int __dev)
     __attribute__ ((__nothrow__));
__extension__
extern __inline unsigned int gnu_dev_minor (unsigned long long int __dev)
     __attribute__ ((__nothrow__));
__extension__
extern __inline unsigned long long int gnu_dev_makedev (unsigned int __major,
       unsigned int __minor)
     __attribute__ ((__nothrow__));


__extension__ extern __inline unsigned int
__attribute__ ((__nothrow__)) gnu_dev_major (unsigned long long int __dev)
{
  return ((__dev >> 8) & 0xfff) | ((unsigned int) (__dev >> 32) & ~0xfff);
}

__extension__ extern __inline unsigned int
__attribute__ ((__nothrow__)) gnu_dev_minor (unsigned long long int __dev)
{
  return (__dev & 0xff) | ((unsigned int) (__dev >> 12) & ~0xff);
}

__extension__ extern __inline unsigned long long int
__attribute__ ((__nothrow__)) gnu_dev_makedev (unsigned int __major, unsigned int __minor)
{
  return ((__minor & 0xff) | ((__major & 0xfff) << 8)
   | (((unsigned long long int) (__minor & ~0xff)) << 12)
   | (((unsigned long long int) (__major & ~0xfff)) << 32));
}
# 224 "/usr/include/sys/types.h" 2 3 4
# 235 "/usr/include/sys/types.h" 3 4
typedef __blkcnt_t blkcnt_t;



typedef __fsblkcnt_t fsblkcnt_t;



typedef __fsfilcnt_t fsfilcnt_t;
# 270 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/bits/pthreadtypes.h" 1 3 4
# 36 "/usr/include/bits/pthreadtypes.h" 3 4
typedef unsigned long int pthread_t;


typedef union
{
  char __size[36];
  long int __align;
} pthread_attr_t;


typedef struct __pthread_internal_slist
{
  struct __pthread_internal_slist *__next;
} __pthread_slist_t;




typedef union
{
  struct __pthread_mutex_s
  {
    int __lock;
    unsigned int __count;
    int __owner;


    int __kind;
    unsigned int __nusers;
    __extension__ union
    {
      int __spins;
      __pthread_slist_t __list;
    };
  } __data;
  char __size[24];
  long int __align;
} pthread_mutex_t;

typedef union
{
  char __size[4];
  long int __align;
} pthread_mutexattr_t;




typedef union
{
  struct
  {
    int __lock;
    unsigned int __futex;
    __extension__ unsigned long long int __total_seq;
    __extension__ unsigned long long int __wakeup_seq;
    __extension__ unsigned long long int __woken_seq;
    void *__mutex;
    unsigned int __nwaiters;
    unsigned int __broadcast_seq;
  } __data;
  char __size[48];
  __extension__ long long int __align;
} pthread_cond_t;

typedef union
{
  char __size[4];
  long int __align;
} pthread_condattr_t;



typedef unsigned int pthread_key_t;



typedef int pthread_once_t;





typedef union
{
  struct
  {
    int __lock;
    unsigned int __nr_readers;
    unsigned int __readers_wakeup;
    unsigned int __writer_wakeup;
    unsigned int __nr_readers_queued;
    unsigned int __nr_writers_queued;


    unsigned char __flags;
    unsigned char __shared;
    unsigned char __pad1;
    unsigned char __pad2;
    int __writer;
  } __data;
  char __size[32];
  long int __align;
} pthread_rwlock_t;

typedef union
{
  char __size[8];
  long int __align;
} pthread_rwlockattr_t;





typedef volatile int pthread_spinlock_t;




typedef union
{
  char __size[20];
  long int __align;
} pthread_barrier_t;

typedef union
{
  char __size[4];
  int __align;
} pthread_barrierattr_t;
# 271 "/usr/include/sys/types.h" 2 3 4



# 439 "/usr/include/stdlib.h" 2 3 4






extern long int random (void) __attribute__ ((__nothrow__));


extern void srandom (unsigned int __seed) __attribute__ ((__nothrow__));





extern char *initstate (unsigned int __seed, char *__statebuf,
   size_t __statelen) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2)));



extern char *setstate (char *__statebuf) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));







struct random_data
  {
    int32_t *fptr;
    int32_t *rptr;
    int32_t *state;
    int rand_type;
    int rand_deg;
    int rand_sep;
    int32_t *end_ptr;
  };

extern int random_r (struct random_data *__restrict __buf,
       int32_t *__restrict __result) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));

extern int srandom_r (unsigned int __seed, struct random_data *__buf)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2)));

extern int initstate_r (unsigned int __seed, char *__restrict __statebuf,
   size_t __statelen,
   struct random_data *__restrict __buf)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2, 4)));

extern int setstate_r (char *__restrict __statebuf,
         struct random_data *__restrict __buf)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));






extern int rand (void) __attribute__ ((__nothrow__));

extern void srand (unsigned int __seed) __attribute__ ((__nothrow__));




extern int rand_r (unsigned int *__seed) __attribute__ ((__nothrow__));







extern double drand48 (void) __attribute__ ((__nothrow__));
extern double erand48 (unsigned short int __xsubi[3]) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern long int lrand48 (void) __attribute__ ((__nothrow__));
extern long int nrand48 (unsigned short int __xsubi[3])
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern long int mrand48 (void) __attribute__ ((__nothrow__));
extern long int jrand48 (unsigned short int __xsubi[3])
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern void srand48 (long int __seedval) __attribute__ ((__nothrow__));
extern unsigned short int *seed48 (unsigned short int __seed16v[3])
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));
extern void lcong48 (unsigned short int __param[7]) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));





struct drand48_data
  {
    unsigned short int __x[3];
    unsigned short int __old_x[3];
    unsigned short int __c;
    unsigned short int __init;
    unsigned long long int __a;
  };


extern int drand48_r (struct drand48_data *__restrict __buffer,
        double *__restrict __result) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));
extern int erand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        double *__restrict __result) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));


extern int lrand48_r (struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));
extern int nrand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));


extern int mrand48_r (struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));
extern int jrand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));


extern int srand48_r (long int __seedval, struct drand48_data *__buffer)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2)));

extern int seed48_r (unsigned short int __seed16v[3],
       struct drand48_data *__buffer) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));

extern int lcong48_r (unsigned short int __param[7],
        struct drand48_data *__buffer)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));









extern void *malloc (size_t __size) __attribute__ ((__nothrow__)) __attribute__ ((__malloc__)) ;

extern void *calloc (size_t __nmemb, size_t __size)
     __attribute__ ((__nothrow__)) __attribute__ ((__malloc__)) ;







extern void *realloc (void *__ptr, size_t __size)
     __attribute__ ((__nothrow__)) __attribute__ ((__malloc__)) __attribute__ ((__warn_unused_result__));

extern void free (void *__ptr) __attribute__ ((__nothrow__));




extern void cfree (void *__ptr) __attribute__ ((__nothrow__));



# 1 "/usr/include/alloca.h" 1 3 4
# 25 "/usr/include/alloca.h" 3 4
# 1 "/usr/lib/gcc/i386-redhat-linux/4.1.2/include/stddef.h" 1 3 4
# 26 "/usr/include/alloca.h" 2 3 4







extern void *alloca (size_t __size) __attribute__ ((__nothrow__));






# 613 "/usr/include/stdlib.h" 2 3 4




extern void *valloc (size_t __size) __attribute__ ((__nothrow__)) __attribute__ ((__malloc__)) ;




extern int posix_memalign (void **__memptr, size_t __alignment, size_t __size)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;




extern void abort (void) __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));



extern int atexit (void (*__func) (void)) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));





extern int on_exit (void (*__func) (int __status, void *__arg), void *__arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));






extern void exit (int __status) __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));

# 658 "/usr/include/stdlib.h" 3 4


extern char *getenv (__const char *__name) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;




extern char *__secure_getenv (__const char *__name)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;





extern int putenv (char *__string) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));





extern int setenv (__const char *__name, __const char *__value, int __replace)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2)));


extern int unsetenv (__const char *__name) __attribute__ ((__nothrow__));






extern int clearenv (void) __attribute__ ((__nothrow__));
# 698 "/usr/include/stdlib.h" 3 4
extern char *mktemp (char *__template) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;
# 709 "/usr/include/stdlib.h" 3 4
extern int mkstemp (char *__template) __attribute__ ((__nonnull__ (1))) ;
# 729 "/usr/include/stdlib.h" 3 4
extern char *mkdtemp (char *__template) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;








extern int system (__const char *__command) ;

# 756 "/usr/include/stdlib.h" 3 4
extern char *realpath (__const char *__restrict __name,
         char *__restrict __resolved) __attribute__ ((__nothrow__)) ;






typedef int (*__compar_fn_t) (__const void *, __const void *);









extern void *bsearch (__const void *__key, __const void *__base,
        size_t __nmemb, size_t __size, __compar_fn_t __compar)
     __attribute__ ((__nonnull__ (1, 2, 5))) ;



extern void qsort (void *__base, size_t __nmemb, size_t __size,
     __compar_fn_t __compar) __attribute__ ((__nonnull__ (1, 4)));



extern int abs (int __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)) ;
extern long int labs (long int __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)) ;












extern div_t div (int __numer, int __denom)
     __attribute__ ((__nothrow__)) __attribute__ ((__const__)) ;
extern ldiv_t ldiv (long int __numer, long int __denom)
     __attribute__ ((__nothrow__)) __attribute__ ((__const__)) ;

# 821 "/usr/include/stdlib.h" 3 4
extern char *ecvt (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4))) ;




extern char *fcvt (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4))) ;




extern char *gcvt (double __value, int __ndigit, char *__buf)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3))) ;




extern char *qecvt (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4))) ;
extern char *qfcvt (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4))) ;
extern char *qgcvt (long double __value, int __ndigit, char *__buf)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3))) ;




extern int ecvt_r (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign, char *__restrict __buf,
     size_t __len) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4, 5)));
extern int fcvt_r (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign, char *__restrict __buf,
     size_t __len) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4, 5)));

extern int qecvt_r (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign,
      char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4, 5)));
extern int qfcvt_r (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign,
      char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4, 5)));







extern int mblen (__const char *__s, size_t __n) __attribute__ ((__nothrow__)) ;


extern int mbtowc (wchar_t *__restrict __pwc,
     __const char *__restrict __s, size_t __n) __attribute__ ((__nothrow__)) ;


extern int wctomb (char *__s, wchar_t __wchar) __attribute__ ((__nothrow__)) ;



extern size_t mbstowcs (wchar_t *__restrict __pwcs,
   __const char *__restrict __s, size_t __n) __attribute__ ((__nothrow__));

extern size_t wcstombs (char *__restrict __s,
   __const wchar_t *__restrict __pwcs, size_t __n)
     __attribute__ ((__nothrow__));








extern int rpmatch (__const char *__response) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;
# 926 "/usr/include/stdlib.h" 3 4
extern int posix_openpt (int __oflag) ;
# 961 "/usr/include/stdlib.h" 3 4
extern int getloadavg (double __loadavg[], int __nelem)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));
# 977 "/usr/include/stdlib.h" 3 4

# 3 "src/communDef.h" 2
# 1 "/usr/include/math.h" 1 3 4
# 30 "/usr/include/math.h" 3 4




# 1 "/usr/include/bits/huge_val.h" 1 3 4
# 35 "/usr/include/math.h" 2 3 4
# 47 "/usr/include/math.h" 3 4
# 1 "/usr/include/bits/mathdef.h" 1 3 4
# 48 "/usr/include/math.h" 2 3 4
# 71 "/usr/include/math.h" 3 4
# 1 "/usr/include/bits/mathcalls.h" 1 3 4
# 53 "/usr/include/bits/mathcalls.h" 3 4


extern double acos (double __x) __attribute__ ((__nothrow__)); extern double __acos (double __x) __attribute__ ((__nothrow__));

extern double asin (double __x) __attribute__ ((__nothrow__)); extern double __asin (double __x) __attribute__ ((__nothrow__));

extern double atan (double __x) __attribute__ ((__nothrow__)); extern double __atan (double __x) __attribute__ ((__nothrow__));

extern double atan2 (double __y, double __x) __attribute__ ((__nothrow__)); extern double __atan2 (double __y, double __x) __attribute__ ((__nothrow__));


extern double cos (double __x) __attribute__ ((__nothrow__)); extern double __cos (double __x) __attribute__ ((__nothrow__));

extern double sin (double __x) __attribute__ ((__nothrow__)); extern double __sin (double __x) __attribute__ ((__nothrow__));

extern double tan (double __x) __attribute__ ((__nothrow__)); extern double __tan (double __x) __attribute__ ((__nothrow__));




extern double cosh (double __x) __attribute__ ((__nothrow__)); extern double __cosh (double __x) __attribute__ ((__nothrow__));

extern double sinh (double __x) __attribute__ ((__nothrow__)); extern double __sinh (double __x) __attribute__ ((__nothrow__));

extern double tanh (double __x) __attribute__ ((__nothrow__)); extern double __tanh (double __x) __attribute__ ((__nothrow__));

# 87 "/usr/include/bits/mathcalls.h" 3 4


extern double acosh (double __x) __attribute__ ((__nothrow__)); extern double __acosh (double __x) __attribute__ ((__nothrow__));

extern double asinh (double __x) __attribute__ ((__nothrow__)); extern double __asinh (double __x) __attribute__ ((__nothrow__));

extern double atanh (double __x) __attribute__ ((__nothrow__)); extern double __atanh (double __x) __attribute__ ((__nothrow__));







extern double exp (double __x) __attribute__ ((__nothrow__)); extern double __exp (double __x) __attribute__ ((__nothrow__));


extern double frexp (double __x, int *__exponent) __attribute__ ((__nothrow__)); extern double __frexp (double __x, int *__exponent) __attribute__ ((__nothrow__));


extern double ldexp (double __x, int __exponent) __attribute__ ((__nothrow__)); extern double __ldexp (double __x, int __exponent) __attribute__ ((__nothrow__));


extern double log (double __x) __attribute__ ((__nothrow__)); extern double __log (double __x) __attribute__ ((__nothrow__));


extern double log10 (double __x) __attribute__ ((__nothrow__)); extern double __log10 (double __x) __attribute__ ((__nothrow__));


extern double modf (double __x, double *__iptr) __attribute__ ((__nothrow__)); extern double __modf (double __x, double *__iptr) __attribute__ ((__nothrow__));

# 127 "/usr/include/bits/mathcalls.h" 3 4


extern double expm1 (double __x) __attribute__ ((__nothrow__)); extern double __expm1 (double __x) __attribute__ ((__nothrow__));


extern double log1p (double __x) __attribute__ ((__nothrow__)); extern double __log1p (double __x) __attribute__ ((__nothrow__));


extern double logb (double __x) __attribute__ ((__nothrow__)); extern double __logb (double __x) __attribute__ ((__nothrow__));

# 152 "/usr/include/bits/mathcalls.h" 3 4


extern double pow (double __x, double __y) __attribute__ ((__nothrow__)); extern double __pow (double __x, double __y) __attribute__ ((__nothrow__));


extern double sqrt (double __x) __attribute__ ((__nothrow__)); extern double __sqrt (double __x) __attribute__ ((__nothrow__));





extern double hypot (double __x, double __y) __attribute__ ((__nothrow__)); extern double __hypot (double __x, double __y) __attribute__ ((__nothrow__));






extern double cbrt (double __x) __attribute__ ((__nothrow__)); extern double __cbrt (double __x) __attribute__ ((__nothrow__));








extern double ceil (double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern double __ceil (double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern double fabs (double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern double __fabs (double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern double floor (double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern double __floor (double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern double fmod (double __x, double __y) __attribute__ ((__nothrow__)); extern double __fmod (double __x, double __y) __attribute__ ((__nothrow__));




extern int __isinf (double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern int __finite (double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));





extern int isinf (double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern int finite (double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern double drem (double __x, double __y) __attribute__ ((__nothrow__)); extern double __drem (double __x, double __y) __attribute__ ((__nothrow__));



extern double significand (double __x) __attribute__ ((__nothrow__)); extern double __significand (double __x) __attribute__ ((__nothrow__));





extern double copysign (double __x, double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern double __copysign (double __x, double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__));

# 231 "/usr/include/bits/mathcalls.h" 3 4
extern int __isnan (double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));



extern int isnan (double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern double j0 (double) __attribute__ ((__nothrow__)); extern double __j0 (double) __attribute__ ((__nothrow__));
extern double j1 (double) __attribute__ ((__nothrow__)); extern double __j1 (double) __attribute__ ((__nothrow__));
extern double jn (int, double) __attribute__ ((__nothrow__)); extern double __jn (int, double) __attribute__ ((__nothrow__));
extern double y0 (double) __attribute__ ((__nothrow__)); extern double __y0 (double) __attribute__ ((__nothrow__));
extern double y1 (double) __attribute__ ((__nothrow__)); extern double __y1 (double) __attribute__ ((__nothrow__));
extern double yn (int, double) __attribute__ ((__nothrow__)); extern double __yn (int, double) __attribute__ ((__nothrow__));






extern double erf (double) __attribute__ ((__nothrow__)); extern double __erf (double) __attribute__ ((__nothrow__));
extern double erfc (double) __attribute__ ((__nothrow__)); extern double __erfc (double) __attribute__ ((__nothrow__));
extern double lgamma (double) __attribute__ ((__nothrow__)); extern double __lgamma (double) __attribute__ ((__nothrow__));

# 265 "/usr/include/bits/mathcalls.h" 3 4
extern double gamma (double) __attribute__ ((__nothrow__)); extern double __gamma (double) __attribute__ ((__nothrow__));






extern double lgamma_r (double, int *__signgamp) __attribute__ ((__nothrow__)); extern double __lgamma_r (double, int *__signgamp) __attribute__ ((__nothrow__));







extern double rint (double __x) __attribute__ ((__nothrow__)); extern double __rint (double __x) __attribute__ ((__nothrow__));


extern double nextafter (double __x, double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern double __nextafter (double __x, double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__));





extern double remainder (double __x, double __y) __attribute__ ((__nothrow__)); extern double __remainder (double __x, double __y) __attribute__ ((__nothrow__));



extern double scalbn (double __x, int __n) __attribute__ ((__nothrow__)); extern double __scalbn (double __x, int __n) __attribute__ ((__nothrow__));



extern int ilogb (double __x) __attribute__ ((__nothrow__)); extern int __ilogb (double __x) __attribute__ ((__nothrow__));
# 359 "/usr/include/bits/mathcalls.h" 3 4





extern double scalb (double __x, double __n) __attribute__ ((__nothrow__)); extern double __scalb (double __x, double __n) __attribute__ ((__nothrow__));
# 72 "/usr/include/math.h" 2 3 4
# 94 "/usr/include/math.h" 3 4
# 1 "/usr/include/bits/mathcalls.h" 1 3 4
# 53 "/usr/include/bits/mathcalls.h" 3 4


extern float acosf (float __x) __attribute__ ((__nothrow__)); extern float __acosf (float __x) __attribute__ ((__nothrow__));

extern float asinf (float __x) __attribute__ ((__nothrow__)); extern float __asinf (float __x) __attribute__ ((__nothrow__));

extern float atanf (float __x) __attribute__ ((__nothrow__)); extern float __atanf (float __x) __attribute__ ((__nothrow__));

extern float atan2f (float __y, float __x) __attribute__ ((__nothrow__)); extern float __atan2f (float __y, float __x) __attribute__ ((__nothrow__));


extern float cosf (float __x) __attribute__ ((__nothrow__)); extern float __cosf (float __x) __attribute__ ((__nothrow__));

extern float sinf (float __x) __attribute__ ((__nothrow__)); extern float __sinf (float __x) __attribute__ ((__nothrow__));

extern float tanf (float __x) __attribute__ ((__nothrow__)); extern float __tanf (float __x) __attribute__ ((__nothrow__));




extern float coshf (float __x) __attribute__ ((__nothrow__)); extern float __coshf (float __x) __attribute__ ((__nothrow__));

extern float sinhf (float __x) __attribute__ ((__nothrow__)); extern float __sinhf (float __x) __attribute__ ((__nothrow__));

extern float tanhf (float __x) __attribute__ ((__nothrow__)); extern float __tanhf (float __x) __attribute__ ((__nothrow__));

# 87 "/usr/include/bits/mathcalls.h" 3 4


extern float acoshf (float __x) __attribute__ ((__nothrow__)); extern float __acoshf (float __x) __attribute__ ((__nothrow__));

extern float asinhf (float __x) __attribute__ ((__nothrow__)); extern float __asinhf (float __x) __attribute__ ((__nothrow__));

extern float atanhf (float __x) __attribute__ ((__nothrow__)); extern float __atanhf (float __x) __attribute__ ((__nothrow__));







extern float expf (float __x) __attribute__ ((__nothrow__)); extern float __expf (float __x) __attribute__ ((__nothrow__));


extern float frexpf (float __x, int *__exponent) __attribute__ ((__nothrow__)); extern float __frexpf (float __x, int *__exponent) __attribute__ ((__nothrow__));


extern float ldexpf (float __x, int __exponent) __attribute__ ((__nothrow__)); extern float __ldexpf (float __x, int __exponent) __attribute__ ((__nothrow__));


extern float logf (float __x) __attribute__ ((__nothrow__)); extern float __logf (float __x) __attribute__ ((__nothrow__));


extern float log10f (float __x) __attribute__ ((__nothrow__)); extern float __log10f (float __x) __attribute__ ((__nothrow__));


extern float modff (float __x, float *__iptr) __attribute__ ((__nothrow__)); extern float __modff (float __x, float *__iptr) __attribute__ ((__nothrow__));

# 127 "/usr/include/bits/mathcalls.h" 3 4


extern float expm1f (float __x) __attribute__ ((__nothrow__)); extern float __expm1f (float __x) __attribute__ ((__nothrow__));


extern float log1pf (float __x) __attribute__ ((__nothrow__)); extern float __log1pf (float __x) __attribute__ ((__nothrow__));


extern float logbf (float __x) __attribute__ ((__nothrow__)); extern float __logbf (float __x) __attribute__ ((__nothrow__));

# 152 "/usr/include/bits/mathcalls.h" 3 4


extern float powf (float __x, float __y) __attribute__ ((__nothrow__)); extern float __powf (float __x, float __y) __attribute__ ((__nothrow__));


extern float sqrtf (float __x) __attribute__ ((__nothrow__)); extern float __sqrtf (float __x) __attribute__ ((__nothrow__));





extern float hypotf (float __x, float __y) __attribute__ ((__nothrow__)); extern float __hypotf (float __x, float __y) __attribute__ ((__nothrow__));






extern float cbrtf (float __x) __attribute__ ((__nothrow__)); extern float __cbrtf (float __x) __attribute__ ((__nothrow__));








extern float ceilf (float __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern float __ceilf (float __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern float fabsf (float __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern float __fabsf (float __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern float floorf (float __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern float __floorf (float __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern float fmodf (float __x, float __y) __attribute__ ((__nothrow__)); extern float __fmodf (float __x, float __y) __attribute__ ((__nothrow__));




extern int __isinff (float __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern int __finitef (float __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));





extern int isinff (float __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern int finitef (float __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern float dremf (float __x, float __y) __attribute__ ((__nothrow__)); extern float __dremf (float __x, float __y) __attribute__ ((__nothrow__));



extern float significandf (float __x) __attribute__ ((__nothrow__)); extern float __significandf (float __x) __attribute__ ((__nothrow__));





extern float copysignf (float __x, float __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern float __copysignf (float __x, float __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__));

# 231 "/usr/include/bits/mathcalls.h" 3 4
extern int __isnanf (float __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));



extern int isnanf (float __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern float j0f (float) __attribute__ ((__nothrow__)); extern float __j0f (float) __attribute__ ((__nothrow__));
extern float j1f (float) __attribute__ ((__nothrow__)); extern float __j1f (float) __attribute__ ((__nothrow__));
extern float jnf (int, float) __attribute__ ((__nothrow__)); extern float __jnf (int, float) __attribute__ ((__nothrow__));
extern float y0f (float) __attribute__ ((__nothrow__)); extern float __y0f (float) __attribute__ ((__nothrow__));
extern float y1f (float) __attribute__ ((__nothrow__)); extern float __y1f (float) __attribute__ ((__nothrow__));
extern float ynf (int, float) __attribute__ ((__nothrow__)); extern float __ynf (int, float) __attribute__ ((__nothrow__));






extern float erff (float) __attribute__ ((__nothrow__)); extern float __erff (float) __attribute__ ((__nothrow__));
extern float erfcf (float) __attribute__ ((__nothrow__)); extern float __erfcf (float) __attribute__ ((__nothrow__));
extern float lgammaf (float) __attribute__ ((__nothrow__)); extern float __lgammaf (float) __attribute__ ((__nothrow__));

# 265 "/usr/include/bits/mathcalls.h" 3 4
extern float gammaf (float) __attribute__ ((__nothrow__)); extern float __gammaf (float) __attribute__ ((__nothrow__));






extern float lgammaf_r (float, int *__signgamp) __attribute__ ((__nothrow__)); extern float __lgammaf_r (float, int *__signgamp) __attribute__ ((__nothrow__));







extern float rintf (float __x) __attribute__ ((__nothrow__)); extern float __rintf (float __x) __attribute__ ((__nothrow__));


extern float nextafterf (float __x, float __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern float __nextafterf (float __x, float __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__));





extern float remainderf (float __x, float __y) __attribute__ ((__nothrow__)); extern float __remainderf (float __x, float __y) __attribute__ ((__nothrow__));



extern float scalbnf (float __x, int __n) __attribute__ ((__nothrow__)); extern float __scalbnf (float __x, int __n) __attribute__ ((__nothrow__));



extern int ilogbf (float __x) __attribute__ ((__nothrow__)); extern int __ilogbf (float __x) __attribute__ ((__nothrow__));
# 359 "/usr/include/bits/mathcalls.h" 3 4





extern float scalbf (float __x, float __n) __attribute__ ((__nothrow__)); extern float __scalbf (float __x, float __n) __attribute__ ((__nothrow__));
# 95 "/usr/include/math.h" 2 3 4
# 141 "/usr/include/math.h" 3 4
# 1 "/usr/include/bits/mathcalls.h" 1 3 4
# 53 "/usr/include/bits/mathcalls.h" 3 4


extern long double acosl (long double __x) __attribute__ ((__nothrow__)); extern long double __acosl (long double __x) __attribute__ ((__nothrow__));

extern long double asinl (long double __x) __attribute__ ((__nothrow__)); extern long double __asinl (long double __x) __attribute__ ((__nothrow__));

extern long double atanl (long double __x) __attribute__ ((__nothrow__)); extern long double __atanl (long double __x) __attribute__ ((__nothrow__));

extern long double atan2l (long double __y, long double __x) __attribute__ ((__nothrow__)); extern long double __atan2l (long double __y, long double __x) __attribute__ ((__nothrow__));


extern long double cosl (long double __x) __attribute__ ((__nothrow__)); extern long double __cosl (long double __x) __attribute__ ((__nothrow__));

extern long double sinl (long double __x) __attribute__ ((__nothrow__)); extern long double __sinl (long double __x) __attribute__ ((__nothrow__));

extern long double tanl (long double __x) __attribute__ ((__nothrow__)); extern long double __tanl (long double __x) __attribute__ ((__nothrow__));




extern long double coshl (long double __x) __attribute__ ((__nothrow__)); extern long double __coshl (long double __x) __attribute__ ((__nothrow__));

extern long double sinhl (long double __x) __attribute__ ((__nothrow__)); extern long double __sinhl (long double __x) __attribute__ ((__nothrow__));

extern long double tanhl (long double __x) __attribute__ ((__nothrow__)); extern long double __tanhl (long double __x) __attribute__ ((__nothrow__));

# 87 "/usr/include/bits/mathcalls.h" 3 4


extern long double acoshl (long double __x) __attribute__ ((__nothrow__)); extern long double __acoshl (long double __x) __attribute__ ((__nothrow__));

extern long double asinhl (long double __x) __attribute__ ((__nothrow__)); extern long double __asinhl (long double __x) __attribute__ ((__nothrow__));

extern long double atanhl (long double __x) __attribute__ ((__nothrow__)); extern long double __atanhl (long double __x) __attribute__ ((__nothrow__));







extern long double expl (long double __x) __attribute__ ((__nothrow__)); extern long double __expl (long double __x) __attribute__ ((__nothrow__));


extern long double frexpl (long double __x, int *__exponent) __attribute__ ((__nothrow__)); extern long double __frexpl (long double __x, int *__exponent) __attribute__ ((__nothrow__));


extern long double ldexpl (long double __x, int __exponent) __attribute__ ((__nothrow__)); extern long double __ldexpl (long double __x, int __exponent) __attribute__ ((__nothrow__));


extern long double logl (long double __x) __attribute__ ((__nothrow__)); extern long double __logl (long double __x) __attribute__ ((__nothrow__));


extern long double log10l (long double __x) __attribute__ ((__nothrow__)); extern long double __log10l (long double __x) __attribute__ ((__nothrow__));


extern long double modfl (long double __x, long double *__iptr) __attribute__ ((__nothrow__)); extern long double __modfl (long double __x, long double *__iptr) __attribute__ ((__nothrow__));

# 127 "/usr/include/bits/mathcalls.h" 3 4


extern long double expm1l (long double __x) __attribute__ ((__nothrow__)); extern long double __expm1l (long double __x) __attribute__ ((__nothrow__));


extern long double log1pl (long double __x) __attribute__ ((__nothrow__)); extern long double __log1pl (long double __x) __attribute__ ((__nothrow__));


extern long double logbl (long double __x) __attribute__ ((__nothrow__)); extern long double __logbl (long double __x) __attribute__ ((__nothrow__));

# 152 "/usr/include/bits/mathcalls.h" 3 4


extern long double powl (long double __x, long double __y) __attribute__ ((__nothrow__)); extern long double __powl (long double __x, long double __y) __attribute__ ((__nothrow__));


extern long double sqrtl (long double __x) __attribute__ ((__nothrow__)); extern long double __sqrtl (long double __x) __attribute__ ((__nothrow__));





extern long double hypotl (long double __x, long double __y) __attribute__ ((__nothrow__)); extern long double __hypotl (long double __x, long double __y) __attribute__ ((__nothrow__));






extern long double cbrtl (long double __x) __attribute__ ((__nothrow__)); extern long double __cbrtl (long double __x) __attribute__ ((__nothrow__));








extern long double ceill (long double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern long double __ceill (long double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern long double fabsl (long double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern long double __fabsl (long double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern long double floorl (long double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern long double __floorl (long double __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern long double fmodl (long double __x, long double __y) __attribute__ ((__nothrow__)); extern long double __fmodl (long double __x, long double __y) __attribute__ ((__nothrow__));




extern int __isinfl (long double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern int __finitel (long double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));





extern int isinfl (long double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern int finitel (long double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern long double dreml (long double __x, long double __y) __attribute__ ((__nothrow__)); extern long double __dreml (long double __x, long double __y) __attribute__ ((__nothrow__));



extern long double significandl (long double __x) __attribute__ ((__nothrow__)); extern long double __significandl (long double __x) __attribute__ ((__nothrow__));





extern long double copysignl (long double __x, long double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern long double __copysignl (long double __x, long double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__));

# 231 "/usr/include/bits/mathcalls.h" 3 4
extern int __isnanl (long double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));



extern int isnanl (long double __value) __attribute__ ((__nothrow__)) __attribute__ ((__const__));


extern long double j0l (long double) __attribute__ ((__nothrow__)); extern long double __j0l (long double) __attribute__ ((__nothrow__));
extern long double j1l (long double) __attribute__ ((__nothrow__)); extern long double __j1l (long double) __attribute__ ((__nothrow__));
extern long double jnl (int, long double) __attribute__ ((__nothrow__)); extern long double __jnl (int, long double) __attribute__ ((__nothrow__));
extern long double y0l (long double) __attribute__ ((__nothrow__)); extern long double __y0l (long double) __attribute__ ((__nothrow__));
extern long double y1l (long double) __attribute__ ((__nothrow__)); extern long double __y1l (long double) __attribute__ ((__nothrow__));
extern long double ynl (int, long double) __attribute__ ((__nothrow__)); extern long double __ynl (int, long double) __attribute__ ((__nothrow__));






extern long double erfl (long double) __attribute__ ((__nothrow__)); extern long double __erfl (long double) __attribute__ ((__nothrow__));
extern long double erfcl (long double) __attribute__ ((__nothrow__)); extern long double __erfcl (long double) __attribute__ ((__nothrow__));
extern long double lgammal (long double) __attribute__ ((__nothrow__)); extern long double __lgammal (long double) __attribute__ ((__nothrow__));

# 265 "/usr/include/bits/mathcalls.h" 3 4
extern long double gammal (long double) __attribute__ ((__nothrow__)); extern long double __gammal (long double) __attribute__ ((__nothrow__));






extern long double lgammal_r (long double, int *__signgamp) __attribute__ ((__nothrow__)); extern long double __lgammal_r (long double, int *__signgamp) __attribute__ ((__nothrow__));







extern long double rintl (long double __x) __attribute__ ((__nothrow__)); extern long double __rintl (long double __x) __attribute__ ((__nothrow__));


extern long double nextafterl (long double __x, long double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__)); extern long double __nextafterl (long double __x, long double __y) __attribute__ ((__nothrow__)) __attribute__ ((__const__));





extern long double remainderl (long double __x, long double __y) __attribute__ ((__nothrow__)); extern long double __remainderl (long double __x, long double __y) __attribute__ ((__nothrow__));



extern long double scalbnl (long double __x, int __n) __attribute__ ((__nothrow__)); extern long double __scalbnl (long double __x, int __n) __attribute__ ((__nothrow__));



extern int ilogbl (long double __x) __attribute__ ((__nothrow__)); extern int __ilogbl (long double __x) __attribute__ ((__nothrow__));
# 359 "/usr/include/bits/mathcalls.h" 3 4





extern long double scalbl (long double __x, long double __n) __attribute__ ((__nothrow__)); extern long double __scalbl (long double __x, long double __n) __attribute__ ((__nothrow__));
# 142 "/usr/include/math.h" 2 3 4
# 157 "/usr/include/math.h" 3 4
extern int signgam;
# 284 "/usr/include/math.h" 3 4
typedef enum
{
  _IEEE_ = -1,
  _SVID_,
  _XOPEN_,
  _POSIX_,
  _ISOC_
} _LIB_VERSION_TYPE;




extern _LIB_VERSION_TYPE _LIB_VERSION;
# 309 "/usr/include/math.h" 3 4
struct exception

  {
    int type;
    char *name;
    double arg1;
    double arg2;
    double retval;
  };




extern int matherr (struct exception *__exc);
# 409 "/usr/include/math.h" 3 4
# 1 "/usr/include/bits/mathinline.h" 1 3 4
# 291 "/usr/include/bits/mathinline.h" 3 4
extern __inline double __sgn (double) __attribute__ ((__nothrow__)); extern __inline double __attribute__ ((__nothrow__)) __sgn (double __x) { return __x == 0.0 ? 0.0 : (__x > 0.0 ? 1.0 : -1.0); } extern __inline float __sgnf (float) __attribute__ ((__nothrow__)); extern __inline float __attribute__ ((__nothrow__)) __sgnf (float __x) { return __x == 0.0 ? 0.0 : (__x > 0.0 ? 1.0 : -1.0); } extern __inline long double __sgnl (long double) __attribute__ ((__nothrow__)); extern __inline long double __attribute__ ((__nothrow__)) __sgnl (long double __x) { return __x == 0.0 ? 0.0 : (__x > 0.0 ? 1.0 : -1.0); }
# 433 "/usr/include/bits/mathinline.h" 3 4
extern __inline long double __attribute__ ((__nothrow__)) __atan2l (long double __y, long double __x) { return __builtin_atan2l (__y, __x); }
# 473 "/usr/include/bits/mathinline.h" 3 4
extern __inline double __attribute__ ((__nothrow__)) fabs (double __x) { return __builtin_fabs (__x); }

extern __inline float __attribute__ ((__nothrow__)) fabsf (float __x) { return __builtin_fabsf (__x); }
extern __inline long double __attribute__ ((__nothrow__)) fabsl (long double __x) { return __builtin_fabsl (__x); }

extern __inline long double __attribute__ ((__nothrow__)) __fabsl (long double __x) { return __builtin_fabsl (__x); }
# 506 "/usr/include/bits/mathinline.h" 3 4
extern __inline long double __sgn1l (long double) __attribute__ ((__nothrow__)); extern __inline long double __attribute__ ((__nothrow__)) __sgn1l (long double __x) { __extension__ union { long double __xld; unsigned int __xi[3]; } __n = { __xld: __x }; __n.__xi[2] = (__n.__xi[2] & 0x8000) | 0x3fff; __n.__xi[1] = 0x80000000; __n.__xi[0] = 0; return __n.__xld; }
# 530 "/usr/include/bits/mathinline.h" 3 4
extern __inline double __attribute__ ((__nothrow__)) floor (double __x) { register long double __value; register int __ignore; unsigned short int __cw; unsigned short int __cwtmp; __asm __volatile ("fnstcw %3\n\t" "movzwl %3, %1\n\t" "andl $0xf3ff, %1\n\t" "orl $0x0400, %1\n\t" "movw %w1, %2\n\t" "fldcw %2\n\t" "frndint\n\t" "fldcw %3" : "=t" (__value), "=&q" (__ignore), "=m" (__cwtmp), "=m" (__cw) : "0" (__x)); return __value; } extern __inline float __attribute__ ((__nothrow__)) floorf (float __x) { register long double __value; register int __ignore; unsigned short int __cw; unsigned short int __cwtmp; __asm __volatile ("fnstcw %3\n\t" "movzwl %3, %1\n\t" "andl $0xf3ff, %1\n\t" "orl $0x0400, %1\n\t" "movw %w1, %2\n\t" "fldcw %2\n\t" "frndint\n\t" "fldcw %3" : "=t" (__value), "=&q" (__ignore), "=m" (__cwtmp), "=m" (__cw) : "0" (__x)); return __value; } extern __inline long double __attribute__ ((__nothrow__)) floorl (long double __x) { register long double __value; register int __ignore; unsigned short int __cw; unsigned short int __cwtmp; __asm __volatile ("fnstcw %3\n\t" "movzwl %3, %1\n\t" "andl $0xf3ff, %1\n\t" "orl $0x0400, %1\n\t" "movw %w1, %2\n\t" "fldcw %2\n\t" "frndint\n\t" "fldcw %3" : "=t" (__value), "=&q" (__ignore), "=m" (__cwtmp), "=m" (__cw) : "0" (__x)); return __value; }
# 548 "/usr/include/bits/mathinline.h" 3 4
extern __inline double __attribute__ ((__nothrow__)) ceil (double __x) { register long double __value; register int __ignore; unsigned short int __cw; unsigned short int __cwtmp; __asm __volatile ("fnstcw %3\n\t" "movzwl %3, %1\n\t" "andl $0xf3ff, %1\n\t" "orl $0x0800, %1\n\t" "movw %w1, %2\n\t" "fldcw %2\n\t" "frndint\n\t" "fldcw %3" : "=t" (__value), "=&q" (__ignore), "=m" (__cwtmp), "=m" (__cw) : "0" (__x)); return __value; } extern __inline float __attribute__ ((__nothrow__)) ceilf (float __x) { register long double __value; register int __ignore; unsigned short int __cw; unsigned short int __cwtmp; __asm __volatile ("fnstcw %3\n\t" "movzwl %3, %1\n\t" "andl $0xf3ff, %1\n\t" "orl $0x0800, %1\n\t" "movw %w1, %2\n\t" "fldcw %2\n\t" "frndint\n\t" "fldcw %3" : "=t" (__value), "=&q" (__ignore), "=m" (__cwtmp), "=m" (__cw) : "0" (__x)); return __value; } extern __inline long double __attribute__ ((__nothrow__)) ceill (long double __x) { register long double __value; register int __ignore; unsigned short int __cw; unsigned short int __cwtmp; __asm __volatile ("fnstcw %3\n\t" "movzwl %3, %1\n\t" "andl $0xf3ff, %1\n\t" "orl $0x0800, %1\n\t" "movw %w1, %2\n\t" "fldcw %2\n\t" "frndint\n\t" "fldcw %3" : "=t" (__value), "=&q" (__ignore), "=m" (__cwtmp), "=m" (__cw) : "0" (__x)); return __value; }
# 727 "/usr/include/bits/mathinline.h" 3 4
extern __inline int
__attribute__ ((__nothrow__)) __finite (double __x)
{
  return (__extension__
   (((((union { double __d; int __i[2]; }) {__d: __x}).__i[1]
      | 0x800fffffu) + 1) >> 31));
}
# 410 "/usr/include/math.h" 2 3 4
# 465 "/usr/include/math.h" 3 4

# 4 "src/communDef.h" 2
# 1 "/usr/include/sys/time.h" 1 3 4
# 27 "/usr/include/sys/time.h" 3 4
# 1 "/usr/include/time.h" 1 3 4
# 28 "/usr/include/sys/time.h" 2 3 4

# 1 "/usr/include/bits/time.h" 1 3 4
# 30 "/usr/include/sys/time.h" 2 3 4
# 39 "/usr/include/sys/time.h" 3 4

# 57 "/usr/include/sys/time.h" 3 4
struct timezone
  {
    int tz_minuteswest;
    int tz_dsttime;
  };

typedef struct timezone *__restrict __timezone_ptr_t;
# 73 "/usr/include/sys/time.h" 3 4
extern int gettimeofday (struct timeval *__restrict __tv,
    __timezone_ptr_t __tz) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));




extern int settimeofday (__const struct timeval *__tv,
    __const struct timezone *__tz)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));





extern int adjtime (__const struct timeval *__delta,
      struct timeval *__olddelta) __attribute__ ((__nothrow__));




enum __itimer_which
  {

    ITIMER_REAL = 0,


    ITIMER_VIRTUAL = 1,



    ITIMER_PROF = 2

  };



struct itimerval
  {

    struct timeval it_interval;

    struct timeval it_value;
  };






typedef int __itimer_which_t;




extern int getitimer (__itimer_which_t __which,
        struct itimerval *__value) __attribute__ ((__nothrow__));




extern int setitimer (__itimer_which_t __which,
        __const struct itimerval *__restrict __new,
        struct itimerval *__restrict __old) __attribute__ ((__nothrow__));




extern int utimes (__const char *__file, __const struct timeval __tvp[2])
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));



extern int lutimes (__const char *__file, __const struct timeval __tvp[2])
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern int futimes (int __fd, __const struct timeval __tvp[2]) __attribute__ ((__nothrow__));
# 191 "/usr/include/sys/time.h" 3 4

# 5 "src/communDef.h" 2

# 1 "include/gif_lib.h" 1
# 21 "include/gif_lib.h"
# 1 "/usr/lib/gcc/i386-redhat-linux/4.1.2/include/stddef.h" 1 3 4
# 22 "include/gif_lib.h" 2
# 1 "/usr/lib/gcc/i386-redhat-linux/4.1.2/include/stdbool.h" 1 3 4
# 23 "include/gif_lib.h" 2







typedef unsigned char GifPixelType;
typedef unsigned char *GifRowType;
typedef unsigned char GifByteType;
typedef unsigned int GifPrefixType;
typedef int GifWord;

typedef struct GifColorType {
    GifByteType Red, Green, Blue;
} GifColorType;

typedef struct ColorMapObject {
    int ColorCount;
    int BitsPerPixel;
    _Bool SortFlag;
    GifColorType *Colors;
} ColorMapObject;

typedef struct GifImageDesc {
    GifWord Left, Top, Width, Height;
    _Bool Interlace;
    ColorMapObject *ColorMap;
} GifImageDesc;

typedef struct ExtensionBlock {
    int ByteCount;
    GifByteType *Bytes;
    int Function;





} ExtensionBlock;

typedef struct SavedImage {
    GifImageDesc ImageDesc;
    GifByteType *RasterBits;
    int ExtensionBlockCount;
    ExtensionBlock *ExtensionBlocks;
} SavedImage;

typedef struct GifFileType {
    GifWord SWidth, SHeight;
    GifWord SColorResolution;
    GifWord SBackGroundColor;
    GifByteType AspectByte;
    ColorMapObject *SColorMap;
    int ImageCount;
    GifImageDesc Image;
    SavedImage *SavedImages;
    int ExtensionBlockCount;
    ExtensionBlock *ExtensionBlocks;
    int Error;
    void *UserData;
    void *Private;
} GifFileType;



typedef enum {
    UNDEFINED_RECORD_TYPE,
    SCREEN_DESC_RECORD_TYPE,
    IMAGE_DESC_RECORD_TYPE,
    EXTENSION_RECORD_TYPE,
    TERMINATE_RECORD_TYPE
} GifRecordType;


typedef int (*InputFunc) (GifFileType *, GifByteType *, int);




typedef int (*OutputFunc) (GifFileType *, const GifByteType *, int);





typedef struct GraphicsControlBlock {
    int DisposalMode;




    _Bool UserInputFlag;
    int DelayTime;
    int TransparentColor;

} GraphicsControlBlock;






GifFileType *EGifOpenFileName(const char *GifFileName,
                              const _Bool GifTestExistence, int *Error);
GifFileType *EGifOpenFileHandle(const int GifFileHandle, int *Error);
GifFileType *EGifOpen(void *userPtr, OutputFunc writeFunc, int *Error);
int EGifSpew(GifFileType * GifFile);
const char *EGifGetGifVersion(GifFileType *GifFile);
int EGifCloseFile(GifFileType *GifFile, int *ErrorCode);
# 147 "include/gif_lib.h"
int EGifPutScreenDesc(GifFileType *GifFile,
                      const int GifWidth, const int GifHeight,
        const int GifColorRes,
                      const int GifBackGround,
                      const ColorMapObject *GifColorMap);
int EGifPutImageDesc(GifFileType *GifFile,
       const int GifLeft, const int GifTop,
                     const int GifWidth, const int GifHeight,
       const _Bool GifInterlace,
                     const ColorMapObject *GifColorMap);
void EGifSetGifVersion(GifFileType *GifFile, const _Bool gif89);
int EGifPutLine(GifFileType *GifFile, GifPixelType *GifLine,
                int GifLineLen);
int EGifPutPixel(GifFileType *GifFile, const GifPixelType GifPixel);
int EGifPutComment(GifFileType *GifFile, const char *GifComment);
int EGifPutExtensionLeader(GifFileType *GifFile, const int GifExtCode);
int EGifPutExtensionBlock(GifFileType *GifFile,
                         const int GifExtLen, const void *GifExtension);
int EGifPutExtensionTrailer(GifFileType *GifFile);
int EGifPutExtension(GifFileType *GifFile, const int GifExtCode,
       const int GifExtLen,
                     const void *GifExtension);
int EGifPutCode(GifFileType *GifFile, int GifCodeSize,
                const GifByteType *GifCodeBlock);
int EGifPutCodeNext(GifFileType *GifFile,
                    const GifByteType *GifCodeBlock);






GifFileType *DGifOpenFileName(const char *GifFileName, int *Error);
GifFileType *DGifOpenFileHandle(int GifFileHandle, int *Error);
int DGifSlurp(GifFileType * GifFile);
GifFileType *DGifOpen(void *userPtr, InputFunc readFunc, int *Error);
    int DGifCloseFile(GifFileType * GifFile, int *ErrorCode);
# 201 "include/gif_lib.h"
int DGifGetScreenDesc(GifFileType *GifFile);
int DGifGetRecordType(GifFileType *GifFile, GifRecordType *GifType);
int DGifGetImageDesc(GifFileType *GifFile);
int DGifGetLine(GifFileType *GifFile, GifPixelType *GifLine, int GifLineLen);
int DGifGetPixel(GifFileType *GifFile, GifPixelType GifPixel);
int DGifGetComment(GifFileType *GifFile, char *GifComment);
int DGifGetExtension(GifFileType *GifFile, int *GifExtCode,
                     GifByteType **GifExtension);
int DGifGetExtensionNext(GifFileType *GifFile, GifByteType **GifExtension);
int DGifGetCode(GifFileType *GifFile, int *GifCodeSize,
                GifByteType **GifCodeBlock);
int DGifGetCodeNext(GifFileType *GifFile, GifByteType **GifCodeBlock);
int DGifGetLZCodes(GifFileType *GifFile, int *GifCode);





int GifQuantizeBuffer(unsigned int Width, unsigned int Height,
                   int *ColorMapSize, GifByteType * RedInput,
                   GifByteType * GreenInput, GifByteType * BlueInput,
                   GifByteType * OutputBuffer,
                   GifColorType * OutputColorMap);




extern const char *GifErrorString(int ErrorCode);
# 239 "include/gif_lib.h"
extern ColorMapObject *GifMakeMapObject(int ColorCount,
                                     const GifColorType *ColorMap);
extern void GifFreeMapObject(ColorMapObject *Object);
extern ColorMapObject *GifUnionColorMap(const ColorMapObject *ColorIn1,
                                     const ColorMapObject *ColorIn2,
                                     GifPixelType ColorTransIn2[]);
extern int GifBitSize(int n);

extern void *
reallocarray(void *optr, size_t nmemb, size_t size);





extern void GifApplyTranslation(SavedImage *Image, GifPixelType Translation[]);
extern int GifAddExtensionBlock(int *ExtensionBlock_Count,
    ExtensionBlock **ExtensionBlocks,
    int Function,
    unsigned int Len, unsigned char ExtData[]);
extern void GifFreeExtensions(int *ExtensionBlock_Count,
         ExtensionBlock **ExtensionBlocks);
extern SavedImage *GifMakeSavedImage(GifFileType *GifFile,
                                  const SavedImage *CopyFrom);
extern void GifFreeSavedImages(GifFileType *GifFile);





int DGifExtensionToGCB(const size_t GifExtensionLength,
         const GifByteType *GifExtension,
         GraphicsControlBlock *GCB);
size_t EGifGCBToExtension(const GraphicsControlBlock *GCB,
         GifByteType *GifExtension);

int DGifSavedExtensionToGCB(GifFileType *GifFile,
       int ImageIndex,
       GraphicsControlBlock *GCB);
int EGifGCBToSavedExtension(const GraphicsControlBlock *GCB,
       GifFileType *GifFile,
       int ImageIndex);







extern const unsigned char GifAsciiTable8x8[][8];

extern void GifDrawText8x8(SavedImage *Image,
                     const int x, const int y,
                     const char *legend, const int color);

extern void GifDrawBox(SavedImage *Image,
                    const int x, const int y,
                    const int w, const int d, const int color);

extern void GifDrawRectangle(SavedImage *Image,
                   const int x, const int y,
                   const int w, const int d, const int color);

extern void GifDrawBoxedText8x8(SavedImage *Image,
                          const int x, const int y,
                          const char *legend,
                          const int border, const int bg, const int fg);
# 7 "src/communDef.h" 2
# 19 "src/communDef.h"
typedef struct pixel
{
    int r ;
    int g ;
    int b ;
} pixel ;


typedef struct animated_gif
{
    int n_images ;
    int * width ;
    int * height ;
    pixel ** p ;
    GifFileType * g ;

} animated_gif ;


typedef struct simpleImage
{
    int offsetX;
    int offsetY;
    int width;
    int height;
    pixel* p;
} simpleImage;

animated_gif* load_pixels( char * filename );

int output_modified_read_gif( char * filename, GifFileType * g );

int store_pixels( char * filename, animated_gif * image );

void apply_gray_filter( animated_gif * image );

void apply_gray_line( animated_gif * image );

void apply_blur_filter( animated_gif * image, int size, int threshold );

void apply_sobel_filter( animated_gif * image );
# 7 "src/parallelSplitMPI.h" 2



int getPartBlur(int height, int width, int size, int myRank, int nbTasks, int* output, int* rank2dim, int* groupDim);

int getPartGlobal(int height, int width, int myRank, int nbTasks, int* output, int* rank2dim, int* groupDim);


void copyImg(pixel* input, pixel* output, int inputWidth, int offsetX, int offsetY, int height, int width);

void writeImg(pixel* input, pixel* output, int inputWidth, int offsetX, int offsetY, int height, int width);


void send(pixel* input, int inputWidth, int offsetX, int offsetY, int height, int width, int targetRank);

void recv(pixel* output, int outputWidth, int offsetX, int offsetY, int height, int width, int sourceRank);

void blurFilter(animated_gif* image, int size, int threshold);

int mainParallelSplitMPI(int argc, char** argv);
# 2 "src/parallelSplitMPI.c" 2

int mainParallelSplitMPI(int argc, char** argv)
{
    printf("Test1\n");
    printf("Test2\n");

    int myRank;
    MPI_Comm_rank(((MPI_Comm) ((void *) &(ompi_mpi_comm_world))), &myRank);

    if(argc < 3)
    {
        fprintf( stderr, "Usage: %s input.gif output.gif \n", argv[0]);



        fflush(stderr);
        MPI_Abort(((MPI_Comm) ((void *) &(ompi_mpi_comm_world))), 1);
    }

    return 0;

    char* input_filename;
    char* output_filename;
    animated_gif* image;
    struct timeval t1, t2;
    double duration;

    input_filename = argv[1] ;
    output_filename = argv[2] ;


    gettimeofday(&t1, ((void *)0));


    image = load_pixels( input_filename ) ;
    if ( image == ((void *)0) ) { return 1 ; }


    gettimeofday(&t2, ((void *)0));

    duration = (t2.tv_sec -t1.tv_sec)+((t2.tv_usec-t1.tv_usec)/1e6);

    if(myRank == 0)
        printf("L %lf\n", duration);




    gettimeofday(&t1, ((void *)0));


    apply_gray_filter( image ) ;


    gettimeofday(&t2, ((void *)0));

    duration = (t2.tv_sec -t1.tv_sec)+((t2.tv_usec-t1.tv_usec)/1e6);

    if(myRank == 0)
        printf("G %lf\n", duration);




    gettimeofday(&t1, ((void *)0));


    blurFilter(image, 5, 20);


    gettimeofday(&t2, ((void *)0));

    duration = (t2.tv_sec -t1.tv_sec)+((t2.tv_usec-t1.tv_usec)/1e6);

    if(myRank == 0)
        printf("B %lf\n", duration);



    if(myRank == 0)
    {

        gettimeofday(&t1, ((void *)0));


        apply_sobel_filter( image ) ;


        gettimeofday(&t2, ((void *)0));

        duration = (t2.tv_sec -t1.tv_sec)+((t2.tv_usec-t1.tv_usec)/1e6);

        printf("S %lf\n", duration);


        gettimeofday(&t1, ((void *)0));


        if ( !store_pixels( output_filename, image ) ) { return 1 ; }


        gettimeofday(&t2, ((void *)0));

        duration = (t2.tv_sec -t1.tv_sec)+((t2.tv_usec-t1.tv_usec)/1e6);

        printf("E %lf\n", duration);
    }

    return 0;
}



void getTileSize(int h, int w, int N, int* size)
{
    int nbX = (int)sqrt(N * w / h);
    int nbY = N / nbX;

    size[0] = h / nbX;
    size[1] = w / nbY;
}

int getPartBlur(int height, int width, int size, int myRank, int nbTasks, int* output, int* rank2dim, int* groupDim)
{
    int groupSize = nbTasks / 2;

    int stripeHeight = height / 10 - size;
    int stripeWidth = width - (2 * size);

    int tileSize[2];
    getTileSize(stripeHeight, stripeWidth, groupSize, tileSize);

    int nbX = stripeHeight / tileSize[0];
    int nbY = stripeWidth / tileSize[1];
    int nbOverX = stripeHeight % tileSize[0];
    int nbOverY = stripeWidth % tileSize[1];

    int offsetX = size;
    int offsetY = size;

    if(myRank >= groupSize)
    {
        offsetX = height - size - stripeHeight;
        myRank -= groupSize;
    }

    int x = myRank / nbY;
    int y = myRank % nbY;
    if(x >= nbX)
    {
        return 0;
    }

    output[0] = offsetX + (x * tileSize[0]) + ((x < nbOverX) ? x : nbOverX);
    output[1] = offsetY + (y * tileSize[1]) + ((y < nbOverY) ? y : nbOverY);
    output[2] = output[0] + tileSize[0] + ((x < nbOverX) ? 1 : 0);
    output[3] = output[1] + tileSize[1] + ((y < nbOverY) ? 1 : 0);

    rank2dim[0] = x;
    rank2dim[1] = y;

    groupDim[0] = nbX;
    groupDim[1] = nbY;

    return 1;
}

int getPartGlobal(int height, int width, int myRank, int nbTasks, int* output, int* rank2dim, int* groupDim)
{
    int tileSize[2];
    getTileSize(height, width, nbTasks, tileSize);

    int nbX = height / tileSize[0];
    int nbY = width / tileSize[1];
    int nbOverX = height % tileSize[0];
    int nbOverY = width % tileSize[1];

    int x = myRank / nbY;
    int y = myRank % nbY;
    if(x >= nbX)
    {
        return 0;
    }

    output[0] = (x * tileSize[0]) + ((x < nbOverX) ? x : nbOverX);
    output[1] = (y * tileSize[1]) + ((y < nbOverY) ? y : nbOverY);
    output[2] = output[0] + tileSize[0] + ((x < nbOverX) ? 1 : 0);
    output[3] = output[1] + tileSize[1] + ((y < nbOverY) ? 1 : 0);

    rank2dim[0] = x;
    rank2dim[1] = y;

    groupDim[0] = nbX;
    groupDim[1] = nbY;

    return 1;
}

void copyImg(pixel* input, pixel* output, int inputWidth, int offsetX, int offsetY, int height, int width)
{
    int i,j;

    for(i = 0; i < height; i++)
    {
        for(j = 0; j < width; j++)
        {
            output[(i)*(width)+(j)].r = input[(offsetX + i)*(inputWidth)+(offsetY + j)].r;
            output[(i)*(width)+(j)].g = input[(offsetX + i)*(inputWidth)+(offsetY + j)].g;
            output[(i)*(width)+(j)].b = input[(offsetX + i)*(inputWidth)+(offsetY + j)].b;
        }
    }
}

void writeImg(pixel* input, pixel* output, int inputWidth, int offsetX, int offsetY, int height, int width)
{
    int i,j;

    for(i = 0; i < height; i++)
    {
        for(j = 0; j < width; j++)
        {
            output[(offsetX + i)*(width)+(offsetY + j)].r = input[(i)*(inputWidth)+(j)].r;
            output[(offsetX + i)*(width)+(offsetY + j)].g = input[(i)*(inputWidth)+(j)].g;
            output[(offsetX + i)*(width)+(offsetY + j)].b = input[(i)*(inputWidth)+(j)].b;
        }
    }
}

void send(pixel* input, int inputWidth, int offsetX, int offsetY, int height, int width, int targetRank)
{
    pixel* buffer;
    int size = height * width * sizeof(pixel);
    buffer = (pixel*)malloc(size);


    copyImg(input, buffer, inputWidth, offsetX, offsetY, height, width);


    MPI_Send(buffer, size, ((MPI_Datatype) ((void *) &(ompi_mpi_byte))), targetRank, 0, ((MPI_Comm) ((void *) &(ompi_mpi_comm_world))));

    free(buffer);
}

void recv(pixel* output, int outputWidth, int offsetX, int offsetY, int height, int width, int sourceRank)
{
    pixel* buffer;
    int size = height * width * sizeof(pixel);
    buffer = (pixel*)malloc(size);


    MPI_Status s;
    MPI_Recv(buffer, size, ((MPI_Datatype) ((void *) &(ompi_mpi_byte))), sourceRank, 0, ((MPI_Comm) ((void *) &(ompi_mpi_comm_world))), &s);


    writeImg(buffer, output, width, offsetX, offsetY, height, outputWidth);

    free(buffer);
}

void blurFilter(animated_gif* image, int size, int threshold)
{
    int i,j,k;
    int width, height;
    int end = 0;
    int n_iter = 0;

    pixel** p;
    pixel* new;

    int shape[4];
    int myDimRank[2];
    int myDimGroup[2];
    int myWidth;
    int myHeight;
    pixel* myImg;

    int myRank;
    int nbTasks;

    MPI_Comm_size(((MPI_Comm) ((void *) &(ompi_mpi_comm_world))), &nbTasks);
    MPI_Comm_rank(((MPI_Comm) ((void *) &(ompi_mpi_comm_world))), &myRank);

    p = image->p;

    for(i = 0; i < image->n_images; i++)
    {
        n_iter = 0;
        width = image->width[i];
        height = image->height[i];

        if(getPartBlur(height, width, size, myRank, nbTasks, shape, myDimRank, myDimGroup))
        {
            myHeight = shape[2] - shape[0] + 2*size;
            myWidth = shape[3] - shape[1] + 2*size;

            myImg = (pixel*)malloc(myHeight * myWidth * sizeof(pixel));


            copyImg(p[i], myImg, width, shape[0] - size, shape[1] - size, myHeight, myWidth);


            new = (pixel*)malloc(myHeight * myWidth * sizeof(pixel));

            do
            {
                end = 1;
                n_iter++;




                if(myDimRank[0] > 0)
                {
                    if(myDimRank[1] > 0)
                    {

                        recv(myImg, myWidth,
                             0, 0,
                             size, size,
                             myRank - myDimGroup[1] -1);
                    }


                    recv(myImg, myWidth,
                         0, size,
                         size, myWidth - 2*size,
                         myRank - myDimGroup[1]);

                    if(myDimRank[1] < myDimGroup[1] - 1)
                    {

                        recv(myImg, myWidth,
                             0, myWidth - size,
                             size, size,
                             myRank - myDimGroup[1] + 1);
                    }
                }

                if(myDimRank[1] > 0)
                {

                    recv(myImg, myWidth,
                         size, 0,
                         myHeight - 2*size, size,
                         myRank - 1);
                }




                if(myDimRank[0] > 0)
                {
                    if(myDimRank[1] > 0)
                    {

                        send(myImg, myWidth,
                             size, size,
                             size, size,
                             myRank - myDimGroup[1] - 1);
                    }


                    send(myImg, myWidth,
                         size, size,
                         size, myWidth - 2*size,
                         myRank - myDimGroup[1]);

                    if(myDimRank[1] < myDimGroup[1] - 1)
                    {

                        send(myImg, myWidth,
                             size, myWidth - 2*size,
                             size, size,
                             myRank - myDimGroup[1] + 1);
                    }
                }

                if(myDimRank[1] > 0)
                {

                    send(myImg, myWidth,
                         size, size,
                         myHeight - 2*size, size,
                         myRank - 1);
                }

                if(myDimRank[1] < myDimGroup[1] - 1)
                {

                    send(myImg, myWidth,
                         size, myWidth - 2*size,
                         myHeight - 2*size, size,
                         myRank + 1);
                }

                if(myDimRank[0] < myDimGroup[0] - 1)
                {
                    if(myDimRank[1] > 0)
                    {

                        send(myImg, myWidth,
                             myHeight - 2*size, size,
                             size, size,
                             myRank + myDimGroup[1] - 1);
                    }


                    send(myImg, myWidth,
                         myHeight - 2*size, size,
                         size, myWidth - 2*size,
                         myRank + myDimGroup[1]);

                    if(myDimRank[1] < myDimGroup[1] - 1)
                    {

                        send(myImg, myWidth,
                             myHeight - 2*size, myWidth - 2*size,
                             size, size,
                             myRank + myDimGroup[1] + 1);
                    }
                }




                if(myDimRank[0] < myDimGroup[0] - 1)
                {
                    if(myDimRank[1] > 0)
                    {

                        recv(myImg, myWidth,
                             myHeight - size, 0,
                             size, size,
                             myRank + myDimGroup[1] -1);
                    }


                    recv(myImg, myWidth,
                         myHeight - size, size,
                         size, myWidth - 2*size,
                         myRank + myDimGroup[1]);

                    if(myDimRank[1] < myDimGroup[1] - 1)
                    {

                        recv(myImg, myWidth,
                             myHeight - size, myWidth - size,
                             size, size,
                             myRank + myDimGroup[1] + 1);
                    }
                }

                if(myDimRank[1] < myDimGroup[1] - 1)
                {

                    recv(myImg, myWidth,
                         size, myWidth - size,
                         myHeight - 2*size, size,
                         myRank + 1);
                }




                for(j = size; j < myHeight - size; j++)
                {
                    for(k = size; k < myWidth - size; k++)
                    {
                        int stencil_j, stencil_k ;
                        int t_r = 0 ;
                        int t_g = 0 ;
                        int t_b = 0 ;

                        for ( stencil_j = -size ; stencil_j <= size ; stencil_j++ )
                        {
                            for ( stencil_k = -size ; stencil_k <= size ; stencil_k++ )
                            {
                                t_r += myImg[(j+stencil_j)*(myWidth)+(k+stencil_k)].r ;
                                t_g += myImg[(j+stencil_j)*(myWidth)+(k+stencil_k)].g ;
                                t_b += myImg[(j+stencil_j)*(myWidth)+(k+stencil_k)].b ;
                            }
                        }

                        new[(j)*(myWidth)+(k)].r = t_r / ( (2*size+1)*(2*size+1) ) ;
                        new[(j)*(myWidth)+(k)].g = t_g / ( (2*size+1)*(2*size+1) ) ;
                        new[(j)*(myWidth)+(k)].b = t_b / ( (2*size+1)*(2*size+1) ) ;
                    }
                }


                for(j = size; j < myHeight - size; j++)
                {
                    for(k = size; k < myWidth - size; k++)
                    {
                        float diff_r;
                        float diff_g;
                        float diff_b;

                        diff_r = new[(j)*(myWidth)+(k)].r - myImg[(j)*(myWidth)+(k)].r;
                        diff_g = new[(j)*(myWidth)+(k)].g - myImg[(j)*(myWidth)+(k)].g;
                        diff_b = new[(j)*(myWidth)+(k)].b - myImg[(j)*(myWidth)+(k)].b;

                        if ( diff_r > threshold || -diff_r > threshold
                             ||
                             diff_g > threshold || -diff_g > threshold
                             ||
                             diff_b > threshold || -diff_b > threshold
                            ) {
                            end = 0 ;
                        }

                        myImg[(j)*(myWidth)+(k)].r = new[(j)*(myWidth)+(k)].r;
                        myImg[(j)*(myWidth)+(k)].g = new[(j)*(myWidth)+(k)].g;
                        myImg[(j)*(myWidth)+(k)].b = new[(j)*(myWidth)+(k)].b;
                    }
                }

                int endReduce;
                MPI_Allreduce(&end, &endReduce, 1, ((MPI_Datatype) ((void *) &(ompi_mpi_int))), ((MPI_Op) ((void *) &(ompi_mpi_op_land))), ((MPI_Comm) ((void *) &(ompi_mpi_comm_world))));
                end = endReduce;

            } while(threshold > 0 && !end);

            free(myImg);
            free(new);
        }
        else
        {

            do
            {
                end = 1;
                int endReduce;
                MPI_Allreduce(&end, &endReduce, 1, ((MPI_Datatype) ((void *) &(ompi_mpi_int))), ((MPI_Op) ((void *) &(ompi_mpi_op_land))), ((MPI_Comm) ((void *) &(ompi_mpi_comm_world))));
                end = endReduce;
            } while(threshold > 0 && !end);
        }
    }
}
