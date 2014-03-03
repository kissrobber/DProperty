#import <XCTest/XCTest.h>
#import "DPropertyTestClass1+Cate1.h"
#import "DPropertyTestClass+Cate.h"
#import "DPPPropertyAttribute.h"

@interface DPropertyTests : XCTestCase

@end

@implementation DPropertyTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDebug
{
    /*
    DPropertyTestClass1 *o = [DPropertyTestClass1 new];
        for (int i = 0; i < 1000000; i++) {
            @autoreleasepool {
                o.idDefault = [NSString stringWithFormat:@"ABBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB %d", i];
                o.doubleDefault = i;
                o.intPointerDefault = &i;
            }
        }
     */
}

- (void)testStatic
{
    DPropertyTestClass1 *o = [DPropertyTestClass1 new];
    DPPPropertyAttribute *pa = [DPPPropertyAttribute propertyWithClass:[o class] propertyName:@"idStatic"];
    XCTAssert(!pa.dynamic, @"dynamic: %d", pa.dynamic);
}

- (void)testAssignAtomic
{
    DPropertyTestClass1 *o = [DPropertyTestClass1 new];
    DPPPropertyAttribute *pa = [DPPPropertyAttribute propertyWithClass:[o class] propertyName:@"idAssignAtomic"];
    
    //TODO: I don't know if this is correct.
    XCTAssert(pa.retentionMethod == OBJC_ASSOCIATION_ASSIGN, @"retentionMethod: %d", pa.retentionMethod);
    XCTAssert(pa.dynamic, @"dynamic: %d", pa.dynamic);
}

- (void)testAssignNonatomic
{
    DPropertyTestClass1 *o = [DPropertyTestClass1 new];
    DPPPropertyAttribute *pa = [DPPPropertyAttribute propertyWithClass:[o class] propertyName:@"idAssignNonatomic"];
    
    //TODO: I don't know if this is correct.
    XCTAssert(pa.retentionMethod == OBJC_ASSOCIATION_ASSIGN, @"retentionMethod: %d", pa.retentionMethod);
    XCTAssert(pa.dynamic, @"dynamic: %d", pa.dynamic);
}

- (void)testRetainAtomic
{
    DPropertyTestClass1 *o = [DPropertyTestClass1 new];
    DPPPropertyAttribute *pa = [DPPPropertyAttribute propertyWithClass:[o class] propertyName:@"idRetainAtomic"];
    
    XCTAssert(pa.retentionMethod == OBJC_ASSOCIATION_RETAIN, @"retentionMethod: %d", pa.retentionMethod);
    XCTAssert(pa.dynamic, @"dynamic: %d", pa.dynamic);
}

- (void)testRetainNonatomic
{
    DPropertyTestClass1 *o = [DPropertyTestClass1 new];
    DPPPropertyAttribute *pa = [DPPPropertyAttribute propertyWithClass:[o class] propertyName:@"idRetainNonatomic"];
    
    XCTAssert(pa.retentionMethod == OBJC_ASSOCIATION_RETAIN_NONATOMIC, @"retentionMethod: %d", pa.retentionMethod);
    XCTAssert(pa.dynamic, @"dynamic: %d", pa.dynamic);
}

- (void)testCopyAtomic
{
    DPropertyTestClass1 *o = [DPropertyTestClass1 new];
    DPPPropertyAttribute *pa = [DPPPropertyAttribute propertyWithClass:[o class] propertyName:@"idCopyAtomic"];
    
    XCTAssert(pa.retentionMethod == OBJC_ASSOCIATION_COPY, @"retentionMethod: %d", pa.retentionMethod);
    XCTAssert(pa.dynamic, @"dynamic: %d", pa.dynamic);
}

- (void)testCopyNonatomic
{
    DPropertyTestClass1 *o = [DPropertyTestClass1 new];
    DPPPropertyAttribute *pa = [DPPPropertyAttribute propertyWithClass:[o class] propertyName:@"idCopyNonatomic"];
    
    XCTAssert(pa.retentionMethod == OBJC_ASSOCIATION_COPY_NONATOMIC, @"retentionMethod: %d", pa.retentionMethod);
    XCTAssert(pa.dynamic, @"dynamic: %d", pa.dynamic);
}

- (void)testStrongAtomic
{
    DPropertyTestClass1 *o = [DPropertyTestClass1 new];
    DPPPropertyAttribute *pa = [DPPPropertyAttribute propertyWithClass:[o class] propertyName:@"idStrongAtomic"];
    
    XCTAssert(pa.retentionMethod == OBJC_ASSOCIATION_RETAIN, @"retentionMethod: %d", pa.retentionMethod);
    XCTAssert(pa.dynamic, @"dynamic: %d", pa.dynamic);
}

- (void)testStrongNonatomic
{
    DPropertyTestClass1 *o = [DPropertyTestClass1 new];
    DPPPropertyAttribute *pa = [DPPPropertyAttribute propertyWithClass:[o class] propertyName:@"idStrongNonatomic"];
    
    XCTAssert(pa.retentionMethod == OBJC_ASSOCIATION_RETAIN_NONATOMIC, @"retentionMethod: %d", pa.retentionMethod);
    XCTAssert(pa.dynamic, @"dynamic: %d", pa.dynamic);
}

- (void)testWeakAtomic
{
    DPropertyTestClass1 *o = [DPropertyTestClass1 new];
    DPPPropertyAttribute *pa = [DPPPropertyAttribute propertyWithClass:[o class] propertyName:@"idWeakAtomic"];
    
    //TODO: I don't know if this is correct.
    XCTAssert(pa.retentionMethod == OBJC_ASSOCIATION_ASSIGN, @"retentionMethod: %d", pa.retentionMethod);
    XCTAssert(pa.dynamic, @"dynamic: %d", pa.dynamic);
}

- (void)testWeakNonatomic
{
    DPropertyTestClass1 *o = [DPropertyTestClass1 new];
    DPPPropertyAttribute *pa = [DPPPropertyAttribute propertyWithClass:[o class] propertyName:@"idWeakNonatomic"];
    
    //TODO: I don't know if this is correct.
    XCTAssert(pa.retentionMethod == OBJC_ASSOCIATION_ASSIGN, @"retentionMethod: %d", pa.retentionMethod);
    XCTAssert(pa.dynamic, @"dynamic: %d", pa.dynamic);
}

- (void)testBoolDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    o1.boolDefault = YES;
    XCTAssert(o1.boolDefault == YES, @"bool: %c", o1.boolDefault);
    o2.boolDefault = NO;
    XCTAssert(o2.boolDefault == NO, @"bool: %c", o2.boolDefault);
    o1.boolDefault = NO;
    XCTAssert(o1.boolDefault == NO, @"bool: %c", o1.boolDefault);
    XCTAssert(o2.boolDefault == NO, @"bool: %c", o2.boolDefault);
}

- (void)testCharDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    DPropertyTestClass *o3 = [DPropertyTestClass new];
    
    o1.charDefault = 'e';
    XCTAssert(o1.charDefault == 'e', @"char: %c", o1.charDefault);
    o2.charDefault = 'b';
    XCTAssert(o2.charDefault == 'b', @"char: %c", o2.charDefault);
    
    o3.charDefault = @"abc";
    
    o1.charDefault = 'c';
    XCTAssert(o1.charDefault == 'c', @"char: %c", o1.charDefault);
    XCTAssert(o2.charDefault == 'b', @"char: %c", o2.charDefault);
}

- (void)testDoubleDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    o1.doubleStatic = 345.0;
    XCTAssert(o1.doubleStatic == 345.0, @"double: %f", o1.doubleStatic);
    
    o1.doubleDefault = 124.0;
    XCTAssert(o1.doubleDefault == 124.0, @"double: %f", o1.doubleDefault);
    o2.doubleDefault = 555;
    XCTAssert(o2.doubleDefault == 555, @"double: %f", o2.doubleDefault);
    
    XCTAssert(o1.doubleDefault == 124.0, @"double: %f", o1.doubleDefault);
    o1.doubleDefault = 456.0;
    XCTAssert(o1.doubleDefault == 456.0, @"double: %f", o1.doubleDefault);
}

- (void)testFloatDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    o1.floatDefault = 124.0f;
    XCTAssert(o1.floatDefault == 124.0f, @"float: %f", o1.floatDefault);
    o2.floatDefault = 555.f;
    XCTAssert(o2.floatDefault == 555.f, @"float: %f", o2.floatDefault);

    XCTAssert(o1.floatDefault == 124.0f, @"float: %f", o1.floatDefault);
    o1.floatDefault = 456.0f;
    XCTAssert(o1.floatDefault == 456.0f, @"float: %f", o1.floatDefault);
}

- (void)testIntDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    o1.intDefault = 124;
    XCTAssert(o1.intDefault == 124, @"int: %d", o1.intDefault);
    o2.intDefault = 555;
    XCTAssert(o2.intDefault == 555, @"int: %d", o2.intDefault);
    o1.intDefault = 456;
    XCTAssert(o1.intDefault == 456, @"int: %d", o1.intDefault);
}

- (void)testIntegerDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    NSInteger i1 = 123;
    NSInteger i2 = 445;
    NSInteger i3 = 678;
    
    o1.integerDefault = i1;
    XCTAssert(o1.integerDefault == i1, @"integer: %ld", o1.integerDefault);
    o2.integerDefault = i2;
    XCTAssert(o2.integerDefault == i2, @"integer: %ld", o2.integerDefault);
    o1.integerDefault = i3;
    XCTAssert(o1.integerDefault == i3, @"integer: %ld", o1.integerDefault);
}

- (void)testLongDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    o1.longDefault = 124;
    XCTAssert(o1.longDefault == 124, @"long: %ld", o1.longDefault);
    o2.longDefault = 555;
    XCTAssert(o2.longDefault == 555, @"long: %ld", o2.longDefault);
    o1.longDefault = 456;
    XCTAssert(o1.longDefault == 456, @"long: %ld", o1.longDefault);
}

- (void)testLongLongDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    o1.longLongDefault = 124;
    XCTAssert(o1.longLongDefault == 124, @"long: %lld", o1.longLongDefault);
    o2.longLongDefault = 555;
    XCTAssert(o2.longLongDefault == 555, @"long: %lld", o2.longLongDefault);
    o1.longLongDefault = 456;
    XCTAssert(o1.longLongDefault == 456, @"long: %lld", o1.longLongDefault);
}

- (void)testShortDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    o1.shortDefault = 124;
    XCTAssert(o1.shortDefault == 124, @"long: %hd", o1.shortDefault);
    o2.shortDefault = 555;
    XCTAssert(o2.shortDefault == 555, @"long: %hd", o2.shortDefault);
    o1.shortDefault = 456;
    XCTAssert(o1.shortDefault == 456, @"long: %hd", o1.shortDefault);
}

- (void)testUnsignedCharDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    o1.unsignedCharDefault = 'z';
    XCTAssert(o1.unsignedCharDefault == 'z', @"uchar: %u", o1.unsignedCharDefault);
    o2.unsignedCharDefault = 'v';
    XCTAssert(o2.unsignedCharDefault == 'v', @"uchar: %u", o2.unsignedCharDefault);
    o1.unsignedCharDefault = '2';
    XCTAssert(o1.unsignedCharDefault == '2', @"uchar: %u", o1.unsignedCharDefault);
}

- (void)testUnsignedDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    o1.unsignedDefault = 124;
    XCTAssert(o1.unsignedDefault == 124, @"uint: %u", o1.unsignedDefault);
    o2.unsignedDefault = 555;
    XCTAssert(o2.unsignedDefault == 555, @"uint: %u", o2.unsignedDefault);
    o1.unsignedDefault = 456;
    XCTAssert(o1.unsignedDefault == 456, @"uint: %u", o1.unsignedDefault);
}

- (void)testUnsignedIntegerDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    o1.unsignedIntegerDefault = 124;
    XCTAssert(o1.unsignedIntegerDefault == 124, @"uint: %lu", o1.unsignedIntegerDefault);
    o2.unsignedIntegerDefault = 555;
    XCTAssert(o2.unsignedIntegerDefault == 555, @"uint: %lu", o2.unsignedIntegerDefault);
    o1.unsignedIntegerDefault = 456;
    XCTAssert(o1.unsignedIntegerDefault == 456, @"uint: %lu", o1.unsignedIntegerDefault);
}

- (void)testUnsignedLongDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    o1.unsignedLongDefault = 124;
    XCTAssert(o1.unsignedLongDefault == 124, @"uint: %lu", o1.unsignedLongDefault);
    o2.unsignedLongDefault = 555;
    XCTAssert(o2.unsignedLongDefault == 555, @"uint: %lu", o2.unsignedLongDefault);
    o1.unsignedLongDefault = 456;
    XCTAssert(o1.unsignedLongDefault == 456, @"uint: %lu", o1.unsignedLongDefault);
}

- (void)testUnsignedShortDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    o1.unsignedShortDefault = 124;
    XCTAssert(o1.unsignedShortDefault == 124, @"uint: %hu", o1.unsignedShortDefault);
    o2.unsignedShortDefault = 555;
    XCTAssert(o2.unsignedShortDefault == 555, @"uint: %hu", o2.unsignedShortDefault);
    o1.unsignedShortDefault = 456;
    XCTAssert(o1.unsignedShortDefault == 456, @"uint: %hu", o1.unsignedShortDefault);
}

- (void)testEnumDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    o1.enumDefault = kEnumDProperty1;
    XCTAssert(o1.enumDefault == kEnumDProperty1, @"enum: %d", o1.enumDefault);
    o2.enumDefault = kEnumDProperty2;
    XCTAssert(o2.enumDefault == kEnumDProperty2, @"enum: %d", o2.enumDefault);

    XCTAssert(o1.enumDefault == kEnumDProperty1, @"enum: %d", o1.enumDefault);
}

- (void)testStructDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    struct StructDProperty s1 = {.x = 2, .y = 1};
    struct StructDProperty s2 = {.x = 5, .y = 4};
    o1.structDefault = s1;
    XCTAssert(o1.structDefault.x == s1.x, @"struct.x: %d", o1.structDefault.x);
    XCTAssert(o1.structDefault.y == s1.y, @"struct.y: %d", o1.structDefault.y);
    o2.structDefault = s2;
    XCTAssert(o2.structDefault.x == s2.x, @"struct.x: %d", o2.structDefault.x);
    XCTAssert(o2.structDefault.y == s2.y, @"struct.y: %d", o2.structDefault.y);

    XCTAssert(o1.structDefault.x == s1.x, @"struct.x: %d", o1.structDefault.x);
    XCTAssert(o1.structDefault.y == s1.y, @"struct.y: %d", o1.structDefault.y);
}

- (void)testTypeOfDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    StructTypeDProperty s1 = {.x = 2, .y = 1};
    StructTypeDProperty s2 = {.x = 5, .y = 4};
    o1.typedefDefault = s1;
    XCTAssert(o1.typedefDefault.x == s1.x, @"struct.x: %d", o1.typedefDefault.x);
    XCTAssert(o1.typedefDefault.y == s1.y, @"struct.y: %d", o1.typedefDefault.y);
    o2.typedefDefault = s2;
    XCTAssert(o2.typedefDefault.x == s2.x, @"struct.x: %d", o2.typedefDefault.x);
    XCTAssert(o2.typedefDefault.y == s2.y, @"struct.y: %d", o2.typedefDefault.y);

    XCTAssert(o1.typedefDefault.x == s1.x, @"struct.x: %d", o1.typedefDefault.x);
    XCTAssert(o1.typedefDefault.y == s1.y, @"struct.y: %d", o1.typedefDefault.y);
}

- (void)testUnionDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    union UnionDProperty s1 = {.x = 2};
    union UnionDProperty s2 = {.y = 4};
    o1.unionDefault = s1;
    XCTAssert(o1.unionDefault.x == s1.x, @"union.x: %d", o1.unionDefault.x);
    XCTAssert(o1.unionDefault.y == s1.y, @"union.y: %d", o1.unionDefault.y);
    o2.unionDefault = s2;
    XCTAssert(o2.unionDefault.x == s2.x, @"union.x: %d", o2.unionDefault.x);
    XCTAssert(o2.unionDefault.y == s2.y, @"union.y: %d", o2.unionDefault.y);

    XCTAssert(o1.unionDefault.x == s1.x, @"union.x: %d", o1.unionDefault.x);
    XCTAssert(o1.unionDefault.y == s1.y, @"union.y: %d", o1.unionDefault.y);
}

int testFunctionDProperty1(char *c)
{
    return 1;
}
int testFunctionDProperty2(char *c)
{
    return 2;
}

- (void)testFunctionPointerDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    int (*f1)(char *) = testFunctionDProperty1;
    int (*f2)(char *) = testFunctionDProperty2;
    o1.functionPointerDefault = f1;
    XCTAssert(o1.functionPointerDefault == f1, @"pointer");
    o2.functionPointerDefault = f2;
    XCTAssert(o2.functionPointerDefault == f2, @"pointer");

    XCTAssert(o1.functionPointerDefault == f1, @"pointer");
}

- (void)testIntPointerDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    int i1 = 1;
    int i2 = 2;
    o1.intPointerDefault = &i1;
    XCTAssert(o1.intPointerDefault == &i1, @"pointer");
    o2.intPointerDefault = &i2;
    XCTAssert(o2.intPointerDefault == &i2, @"pointer");

    XCTAssert(o1.intPointerDefault == &i1, @"pointer");
}

- (void)testVoidPointerDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    double d1 = 1.;
    double d2 = 2.;
    void *v1 = &d1;
    void *v2 = &d2;
    o1.voidPointerDefault = v1;
    XCTAssert(o1.voidPointerDefault == v1, @"pointer");
    o2.voidPointerDefault = v2;
    XCTAssert(o2.voidPointerDefault == v2, @"pointer");

    XCTAssert(o1.voidPointerDefault == v1, @"pointer");
}

- (void)testIdDefault
{
    DPropertyTestClass1 *o1 = [DPropertyTestClass1 new];
    DPropertyTestClass1 *o2 = [DPropertyTestClass1 new];
    
    o1.idDefault = @"a";
    XCTAssert([o1.idDefault isEqual:@"a"], @"id: %@", o1.idDefault);
    o2.idDefault = @"c";
    XCTAssert([o2.idDefault isEqual:@"c"], @"id: %@", o2.idDefault);
    o1.idDefault = @"b";
    XCTAssert([o1.idDefault isEqual:@"b"], @"id: %@", o1.idDefault);
}

@end
