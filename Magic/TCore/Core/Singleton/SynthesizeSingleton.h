// A nice macro used to turn any class into a Singleton by providing the correct methods
// Instance is then retrieved by [ClassName getInstance]
//
// Usage:
// #import "SynthesizeSingleton.h"
// SYNTHESIZE_SINGLETON_FOR_CLASS(ClassName);

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
+ (classname *)getInstance \
{\
\
static dispatch_once_t pred; \
\
static classname *instance = nil; \
\
dispatch_once(&pred, ^{ \
\
instance = [[self alloc] init]; \
\
} \
\
);\
return instance; \
} \
