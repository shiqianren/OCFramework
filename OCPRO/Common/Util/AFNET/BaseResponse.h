//
//  BaseResponse.h
//  OCPRO
//
//  Created by shiqianren on 2017/5/3.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResponse : NSObject<NSCoding>
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) id object;
@property (nonatomic, strong) id params;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

// utility
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end
