//
//  BaseResponse.m
//  OCPRO
//
//  Created by shiqianren on 2017/5/3.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import "BaseResponse.h"
#import "NSDictionaryAdditions.h"
NSString *const BRCodeKey = @"code";
NSString *const BRMsgKey = @"message";
NSString *const BRDataKey = @"data";

@implementation BaseResponse
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if (self && dict && [dict isKindOfClass:[NSDictionary class]])
    {
        self.code = [NSString stringWithFormat:@"%@", [self objectOrNilForKey:BRCodeKey fromDictionary:dict]];
        self.msg = [self objectOrNilForKey:BRMsgKey fromDictionary:dict];
        self.object = [self objectOrNilForKey:BRDataKey fromDictionary:dict];
        self.params = [self objectOrNilForKey:@"params" fromDictionary:dict];
    }
    return self;
}

+ (BaseResponse *)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

#pragma mark - NSCoding Protocol

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.code= [aDecoder decodeObjectForKey:@"code"];
        self.msg = [aDecoder decodeObjectForKey:@"msg"];
        self.object = [aDecoder decodeObjectForKey:@"data"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_code forKey:@"code"];
    [aCoder encodeObject:_msg forKey:@"msg"];
    [aCoder encodeObject:_object forKey:@"data"];
}

@end
