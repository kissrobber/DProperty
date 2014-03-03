#import "DPPPropertyAttribute.h"

@implementation DPPPropertyAttribute

- (id)init
{
    self = [super init];
    if (self != nil) {
        self.retentionMethod = OBJC_ASSOCIATION_ASSIGN;
        self.dynamic = NO;
    }
    return self;
}

+ (DPPPropertyAttribute*) propertyWithClass:(id)class propertyName:(NSString*)propertyName
{
    return [[DPPPropertyAttribute alloc] initWithClass:class propertyName:propertyName];
}

- (id) initWithClass:(id)class propertyName:(NSString*)propertyName
{
    self = [self init];
    objc_property_t property = class_getProperty(class, [propertyName UTF8String]);
    const char *attrs = property_getAttributes(property);
	if ( attrs == NULL )
		return self;
    
    const char *p = attrs;
    char retentionMethod;
    BOOL atomic = YES;
    BOOL weak = NO;
	do
	{
		if(p == NULL){
			break;
        } else if(p[0] == '\0'){
			break;
        } else if(p[0] == 'T'){
            self.type = p[1];
		} else if(p[1] == '&'){
            retentionMethod = '&';
		} else if(p[1] == 'C'){
            retentionMethod = 'C';
        } else if(p[1] == 'N'){
            atomic = NO;
        } else if(p[1] == 'W'){
            weak = YES;
        } else if(p[1] == 'D'){
            self.dynamic = YES;
        }
		p = strchr(p+1, ',' );
	} while (1);
    
    if([self isPrimitive] || [self isPointer]){
        //being converted to NSNumber when saving.
        self.retentionMethod = OBJC_ASSOCIATION_RETAIN;
    } else {
        if(weak){
            //
        } else if(retentionMethod == '&' && atomic){
            self.retentionMethod = OBJC_ASSOCIATION_RETAIN;
        } else if(retentionMethod == '&' && !atomic){
            self.retentionMethod = OBJC_ASSOCIATION_RETAIN_NONATOMIC;
        } else if(retentionMethod == 'C' && atomic){
            self.retentionMethod = OBJC_ASSOCIATION_COPY;
        } else if(retentionMethod == 'C' && !atomic){
            self.retentionMethod = OBJC_ASSOCIATION_COPY_NONATOMIC;
        }
    }
    
    self.key = property;
    
    return self;
}

- (BOOL) isPrimitive
{
    return self.type == 'c' ||
    self.type == 'd' ||
    self.type == 'i' ||
    self.type == 'f' ||
    self.type == 'q' ||
    self.type == 'l' ||
    self.type == 's' ||
    self.type == 'C' ||
    self.type == 'I' ||
    self.type == 'Q' ||
    self.type == 'S' ||
    self.type == 'B';
}

- (BOOL) isPointer
{
    return self.type == '{' ||
    self.type == '(' ||
    self.type == '^';
}

@end
