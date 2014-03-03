#import "DPropertyTestClass1.h"
#import "NSObject+DProperty.h"

typedef enum EnumDProperty{
    kEnumDProperty1,
    kEnumDProperty2
} EnumDProperty;

typedef struct {
    int x, y;
} StructTypeDProperty;

struct StructDProperty
{
    int x, y;
};

union UnionDProperty
{
    int x, y;
};

@interface DPropertyTestClass1 (Cate1)

@property (nonatomic)BOOL boolDefault; //
@property char charDefault; //Tc,VcharDefault
@property double doubleDefault; //Td,VdoubleDefault
@property float floatDefault; //Tf,VfloatDefault
@property int intDefault; //Ti,VintDefault
@property NSInteger integerDefault; //
@property long longDefault; //Tl,VlongDefault
@property long long longLongDefault; //
@property short shortDefault; //Ts,VshortDefault
@property unsigned unsignedDefault; //TI,VunsignedDefault

@property unsigned char unsignedCharDefault; //
@property unsigned int unsignedIntDefault; //
@property NSUInteger unsignedIntegerDefault; //
@property unsigned long unsignedLongDefault; //
@property unsigned long long unsignedLongLongDefault; //
@property unsigned short unsignedShortDefault; //

@property enum EnumDProperty enumDefault; //Ti,VenumDefault
@property struct StructDProperty structDefault; //T{YorkshireTeaStruct="pot"i"lady"c},VstructDefault
@property StructTypeDProperty typedefDefault; //T{YorkshireTeaStruct="pot"i"lady"c},VtypedefDefault
@property union UnionDProperty unionDefault; //T(MoneyUnion="alone"f"down"d),VunionDefault
@property int (*functionPointerDefault)(char *); //T^?,VfunctionPointerDefault
@property int *intPointerDefault; //T^i,VintPointer
@property void *voidPointerDefault; //T^v,VvoidPointerDefault

@property id idDefault; //T@,VidDefault

@property(assign, atomic) id idAssignAtomic;
@property(assign, nonatomic) id idAssignNonatomic;
@property(retain, atomic) id idRetainAtomic;
@property(retain, nonatomic) id idRetainNonatomic;
@property(copy, atomic) id idCopyAtomic;
@property(copy, nonatomic) id idCopyNonatomic;
@property(strong, atomic) id idStrongAtomic;
@property(strong, nonatomic) id idStrongNonatomic;
@property(weak, atomic) id idWeakAtomic;
@property(weak, nonatomic) id idWeakNonatomic;

@end
