#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <string.h>

/* Rprintf is used for debugging in the FREE macro, so ensure R headers
	are available when this header is included. */
#include <R.h>

#undef MALLOC
#define	MALLOC(name,len,type) {	\
	 (name) = (type *)malloc( (len) * sizeof(type) ); \
	 if ((name) == NULL) { \
		error("Memory allocation failed"); \
	 } \
}

#undef CALLOC
#define	CALLOC(name,len,type) { \
	 (name) = (type *)calloc( (len) , sizeof(type) ); \
	 if ((name) == NULL) { \
		error("Memory allocation failed"); \
	 } \
}

#undef REALLOC
#define	REALLOC(name,len,type) { \
	(name) = (type *)realloc((name),(len)*sizeof(type)); \
	if ((name) == NULL) { \
		error("Memory allocation failed"); \
	} \
}

#undef FREE
#define	FREE(name) { \
	if ((name) != NULL) { \
		free((name)); \
	} \
	(name) = NULL; \
}
