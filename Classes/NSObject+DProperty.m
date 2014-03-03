#import "NSObject+DProperty.h"
#import <objc/runtime.h>
#import "DPPPropertyAttribute.h"

static void *DPPPropertyDictionaryKey;

@interface NSObject ()

@property (readonly, nonatomic) NSMutableDictionary* DPP_keysDictionary;

@end

@implementation NSObject (DProperty)

NSString* DPP_propertyNameOf(SEL aSEL)
{
    NSString *name = NSStringFromSelector(aSEL);
    if ([name hasPrefix:@"set"])
    {
        NSString *cap = [name substringWithRange:NSMakeRange(3, 1)];
        NSString *tail = [[name substringFromIndex:4] stringByReplacingOccurrencesOfString:@":" withString:@""];
        name = [NSString stringWithFormat:@"%@%@", [cap lowercaseString], tail];
        return name;
    }
    else
    {
        return name;
    }
}

+ (BOOL)DPP_resolveInstanceMethod:(SEL)aSEL
{
    if([self DPP_resolveInstanceMethod:aSEL]){
        return YES;
    }

    NSString *methodName = NSStringFromSelector(aSEL);
    NSString *propertyName = DPP_propertyNameOf(aSEL);
    if(class_getProperty(self, [propertyName UTF8String])) {
        DPPPropertyAttribute *pa = [self EPC_getAttrOf:propertyName];
        if(pa.dynamic){
            if ([methodName hasPrefix:@"set"]) {
                return [self DPP_addSetter:aSEL property:pa];
            } else {
                return [self DPP_getterSetter:aSEL property:pa];
            }
        }
    }
    return NO;
}

+ (BOOL)DPP_addSetter:(SEL)aSEL property:(DPPPropertyAttribute *)property
{
    switch (property.type) {
        case '@':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorIdSetter, "v@:@");
            return YES;
            break;
        case 'c':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorCharSetter, "v@:@");
            return YES;
            break;
        case 'd':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorDoubleSetter, "v@:@");
            return YES;
            break;
        case 'f':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorFloatSetter, "v@:@");
            return YES;
            break;
        case 'i':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorIntSetter, "v@:@");
            return YES;
            break;
        case 'q':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorLongLongSetter, "v@:@");
            return YES;
            break;
        case 'l':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorLongSetter, "v@:@");
            return YES;
            break;
        case 's':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorShortSetter, "v@:@");
            return YES;
            break;
        case 'C':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorUnsignedCharSetter, "v@:@");
            return YES;
            break;
        case 'I':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorUnsignedSetter, "v@:@");
            return YES;
            break;
        case 'Q':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorUnsignedLongLongSetter, "v@:@");
            return YES;
            break;
        case 'S':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorUnsignedShortSetter, "v@:@");
            return YES;
            break;
        case '{':
        case '(':
        case '^':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorPointerSetter, "v@:@");
            return YES;
            break;
        case 'B':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorBOOLSetter, "v@:@");
            return YES;
            break;
        default:
            return NO;
            break;
    }
}

+ (BOOL)DPP_getterSetter:(SEL)aSEL property:(DPPPropertyAttribute *)property
{
    switch (property.type) {
        case '@':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorIdGetter, "@@:");
            return YES;
            break;
        case 'c':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorCharGetter, "@@:");
            return YES;
            break;
        case 'd':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorDoubleGetter, "@@:");
            return YES;
            break;
        case 'f':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorFloatGetter, "@@:");
            return YES;
            break;
        case 'i':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorIntGetter, "@@:");
            return YES;
            break;
        case 'q':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorLongLongGetter, "@@:");
            return YES;
            break;
        case 'l':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorLongGetter, "@@:");
            return YES;
            break;
        case 's':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorShortGetter, "@@:");
            return YES;
            break;
        case 'C':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorUnsignedCharGetter, "@@:");
            return YES;
            break;
        case 'I':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorUnsignedGetter, "@@:");
            return YES;
            break;
        case 'Q':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorUnsignedLongLongGetter, "@@:");
            return YES;
            break;
        case 'S':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorUnsignedShortGetter, "@@:");
            return YES;
            break;
        case '{':
        case '(':
        case '^':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorPointerGetter, "@@:");
            return YES;
            break;
        case 'B':
            class_addMethod([self class], aSEL, (IMP) DPP_accessorBOOLGetter, "@@:");
            return YES;
            break;
        default:
            return NO;
            break;
    }

}

#pragma initialize
__attribute__((constructor))
static void DPP_initialize()
{
    static BOOL initialized = NO;
    if(!initialized){
        SEL originalSelector = @selector(resolveInstanceMethod:);
        SEL overrideSelector = @selector(DPP_resolveInstanceMethod:);
        Method originalMethod = class_getClassMethod([NSObject class], originalSelector);
        Method overrideMethod = class_getClassMethod([NSObject class], overrideSelector);
        method_exchangeImplementations(originalMethod, overrideMethod);
        initialized = YES;
    }
}

#pragma properties
+ (void)setDPP_keysDictionary:(NSMutableDictionary*)dict
{
    objc_setAssociatedObject(self, &DPPPropertyDictionaryKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (NSMutableDictionary*)DPP_keysDictionary
{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &DPPPropertyDictionaryKey);
    if(dict == nil){
        @synchronized(dict){
            dict = objc_getAssociatedObject(self, &DPPPropertyDictionaryKey);
            if(dict == nil){
                dict = [NSMutableDictionary dictionary];
                self.DPP_keysDictionary = dict;
            }
        }
    }
    return dict;
}

+ (DPPPropertyAttribute *) EPC_getAttrOf:(NSString*) propertyName
{
    NSMutableDictionary *dict = self.DPP_keysDictionary;
    DPPPropertyAttribute *prop = dict[propertyName];
    if(prop == nil){
        @synchronized(dict){
            prop = dict[propertyName];
            if(prop == nil){
                prop = [DPPPropertyAttribute propertyWithClass:[self class] propertyName:propertyName];
                dict[propertyName] = prop;
            }
        }
    }
    return prop;
}

#pragma setter and getter
DPPPropertyAttribute* DPP_getProp(id self, SEL _cmd)
{
    NSObject *me = self;
    NSString *propertyName = DPP_propertyNameOf(_cmd);
    return [[me class] EPC_getAttrOf:propertyName];
}

void DPP_accessorIdSetter(id self, SEL _cmd, id newValue)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    objc_setAssociatedObject(self, prop.key, newValue, prop.retentionMethod);
}
id DPP_accessorIdGetter(id self, SEL _cmd)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    return objc_getAssociatedObject(self, prop.key);
}

void DPP_accessorBOOLSetter(id self, SEL _cmd, BOOL newValue)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    id tmp = [NSNumber numberWithBool:newValue];
    objc_setAssociatedObject(self, prop.key, tmp, prop.retentionMethod);
}
BOOL DPP_accessorBOOLGetter(id self, SEL _cmd)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    NSNumber *tmp = objc_getAssociatedObject(self, prop.key);
    return [tmp boolValue];
}

void DPP_accessorCharSetter(id self, SEL _cmd, char newValue)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    id tmp = [NSNumber numberWithChar:newValue];
    objc_setAssociatedObject(self, prop.key, tmp, prop.retentionMethod);
}
char DPP_accessorCharGetter(id self, SEL _cmd)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    NSNumber *tmp = objc_getAssociatedObject(self, prop.key);
    return [tmp charValue];
}

void DPP_accessorDoubleSetter(id self, SEL _cmd, double newValue)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    id tmp = [NSNumber numberWithDouble:newValue];
    objc_setAssociatedObject(self, prop.key, tmp, prop.retentionMethod);
}
double DPP_accessorDoubleGetter(id self, SEL _cmd)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    NSNumber *tmp = objc_getAssociatedObject(self, prop.key);
    return [tmp doubleValue];
}

void DPP_accessorFloatSetter(id self, SEL _cmd, float newValue)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    id tmp = [NSNumber numberWithFloat:newValue];
    objc_setAssociatedObject(self, prop.key, tmp, prop.retentionMethod);
}
float DPP_accessorFloatGetter(id self, SEL _cmd)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    NSNumber *tmp = objc_getAssociatedObject(self, prop.key);
    return [tmp floatValue];
}

void DPP_accessorIntSetter(id self, SEL _cmd, int newValue)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    id tmp = [NSNumber numberWithInt:newValue];
    objc_setAssociatedObject(self, prop.key, tmp, prop.retentionMethod);
}
int DPP_accessorIntGetter(id self, SEL _cmd)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    NSNumber *tmp = objc_getAssociatedObject(self, prop.key);
    return [tmp intValue];
}

void DPP_accessorLongSetter(id self, SEL _cmd, long newValue)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    id tmp = [NSNumber numberWithLong:newValue];
    objc_setAssociatedObject(self, prop.key, tmp, prop.retentionMethod);
}
long DPP_accessorLongGetter(id self, SEL _cmd)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    NSNumber *tmp = objc_getAssociatedObject(self, prop.key);
    return [tmp longValue];
}

void DPP_accessorLongLongSetter(id self, SEL _cmd, long long newValue)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    id tmp = [NSNumber numberWithLongLong:newValue];
    objc_setAssociatedObject(self, prop.key, tmp, prop.retentionMethod);
}
long DPP_accessorLongLongGetter(id self, SEL _cmd)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    NSNumber *tmp = objc_getAssociatedObject(self, prop.key);
    return [tmp longLongValue];
}

void DPP_accessorShortSetter(id self, SEL _cmd, long newValue)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    id tmp = [NSNumber numberWithShort:newValue];
    objc_setAssociatedObject(self, prop.key, tmp, prop.retentionMethod);
}
short DPP_accessorShortGetter(id self, SEL _cmd)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    NSNumber *tmp = objc_getAssociatedObject(self, prop.key);
    return [tmp shortValue];
}

void DPP_accessorUnsignedCharSetter(id self, SEL _cmd, unsigned char newValue)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    id tmp = [NSNumber numberWithUnsignedChar:newValue];
    objc_setAssociatedObject(self, prop.key, tmp, prop.retentionMethod);
}
unsigned char DPP_accessorUnsignedCharGetter(id self, SEL _cmd)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    NSNumber *tmp = objc_getAssociatedObject(self, prop.key);
    return [tmp unsignedCharValue];
}

void DPP_accessorUnsignedSetter(id self, SEL _cmd, unsigned newValue)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    id tmp = [NSNumber numberWithUnsignedInt:newValue];
    objc_setAssociatedObject(self, prop.key, tmp, prop.retentionMethod);
}
unsigned DPP_accessorUnsignedGetter(id self, SEL _cmd)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    NSNumber *tmp = objc_getAssociatedObject(self, prop.key);
    return [tmp unsignedIntValue];
}

void DPP_accessorUnsignedLongLongSetter(id self, SEL _cmd, unsigned newValue)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    id tmp = [NSNumber numberWithUnsignedLongLong:newValue];
    objc_setAssociatedObject(self, prop.key, tmp, prop.retentionMethod);
}
unsigned long long DPP_accessorUnsignedLongLongGetter(id self, SEL _cmd)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    NSNumber *tmp = objc_getAssociatedObject(self, prop.key);
    return [tmp unsignedLongLongValue];
}

void DPP_accessorUnsignedShortSetter(id self, SEL _cmd, unsigned short newValue)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    id tmp = [NSNumber numberWithUnsignedShort:newValue];
    objc_setAssociatedObject(self, prop.key, tmp, prop.retentionMethod);
}
unsigned short DPP_accessorUnsignedShortGetter(id self, SEL _cmd)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    NSNumber *tmp = objc_getAssociatedObject(self, prop.key);
    return [tmp unsignedShortValue];
}

void DPP_accessorPointerSetter(id self, SEL _cmd, void *newValue)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    id tmp = [NSValue valueWithPointer:newValue];
    objc_setAssociatedObject(self, prop.key, tmp, prop.retentionMethod);
}
void* DPP_accessorPointerGetter(id self, SEL _cmd)
{
    DPPPropertyAttribute *prop = DPP_getProp(self, _cmd);
    NSValue *tmp = objc_getAssociatedObject(self, prop.key);
    return [tmp pointerValue];
}

@end
