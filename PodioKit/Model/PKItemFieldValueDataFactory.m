//
//  POItemFieldValueDataFactory.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/4/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKItemFieldValueDataFactory.h"
#import "PKItemFieldValueContactData.h"
#import "PKItemFieldValueItemData.h"
#import "PKItemFieldValueMoneyData.h"
#import "PKItemFieldValueDateData.h"
#import "PKItemFieldValueImageData.h"
#import "PKItemFieldValueEmbedData.h"
#import "PKItemFieldValueMediaData.h"
#import "PKItemFieldValueVideoData.h"
#import "PKItemFieldValueCalculationData.h"
#import "PKItemFieldValueOptionData.h"
#import "NSDictionary+PKAdditions.h"

@implementation PKItemFieldValueDataFactory

+ (id)dataFromDictionary:(NSDictionary *)dict fieldType:(NSString *)fieldType {
  id data = nil;
  
  if ([fieldType isEqualToString:kPKAppFieldTypeContact]) {
    data = [PKItemFieldValueContactData dataFromDictionary:dict];
  } 
  else if ([fieldType isEqualToString:kPKAppFieldTypeApp]) {
    data = [PKItemFieldValueItemData dataFromDictionary:dict];
  }
  else if ([fieldType isEqualToString:kPKAppFieldTypeMoney]) {
    data = [PKItemFieldValueMoneyData dataFromDictionary:dict];
  }
  else if ([fieldType isEqualToString:kPKAppFieldTypeDate]) {
    data = [PKItemFieldValueDateData dataFromDictionary:dict];
  }
  else if ([fieldType isEqualToString:kPKAppFieldTypeImage]) {
    data = [PKItemFieldValueImageData dataFromDictionary:dict];
  }
  else if ([fieldType isEqualToString:kPKAppFieldTypeEmbed]) {
    data = [PKItemFieldValueEmbedData dataFromDictionary:dict];
  }
  else if ([fieldType isEqualToString:kPKAppFieldTypeMedia]) {
    // Media
    data = [PKItemFieldValueMediaData dataFromDictionary:dict];
  }
  else if ([fieldType isEqualToString:kPKAppFieldTypeVideo]) {
    // Video
    data = [PKItemFieldValueVideoData dataFromDictionary:dict];
  }
  else if ([fieldType isEqualToString:kPKAppFieldTypeCalculation]) {
    // Calculation
    data = [PKItemFieldValueCalculationData dataFromDictionary:dict];
  }
  else if ([fieldType isEqualToString:kPKAppFieldTypeNumber]) {
    // Numeric
    data = [dict pk_numberFromStringForKey:@"value"];
  }
  else if ([fieldType isEqualToString:kPKAppFieldTypeState]) {
    // State
    PKItemFieldValueOptionData *optionData = [PKItemFieldValueOptionData data];
    
    optionData.optionId = -1; // No option id
    optionData.text = [dict pk_objectForKey:@"value"];
    optionData.selected = YES;
    
    data = optionData;
  }
  else if ([fieldType isEqualToString:kPKAppFieldTypeCategory]) {
    // Category
    PKItemFieldValueOptionData *optionData = [PKItemFieldValueOptionData data];
    
    NSDictionary *optionDict = [dict pk_objectForKey:@"value"];
    optionData.optionId = [[optionDict pk_objectForKey:@"id"] integerValue];
    optionData.text = [optionDict pk_objectForKey:@"text"];
    optionData.selected = YES;
    
    data = optionData;
  }
  else if ([fieldType isEqualToString:kPKAppFieldTypeQuestion]) {
    // Answer
    PKItemFieldValueOptionData *optionData = [PKItemFieldValueOptionData data];
    
    NSDictionary *answerDict = [dict pk_objectForKey:@"value"];
    optionData.optionId = [[answerDict pk_objectForKey:@"id"] integerValue];
    optionData.text = [answerDict pk_objectForKey:@"text"];
    optionData.selected = YES;
    
    data = optionData;
  }
  else if ([fieldType isEqualToString:kPKAppFieldTypeText] ||
           [fieldType isEqualToString:kPKAppFieldTypeDuration] ||
           [fieldType isEqualToString:kPKAppFieldTypeLocation] ||
           [fieldType isEqualToString:kPKAppFieldTypeProgress]) {
    // String or number
    data = [dict pk_objectForKey:@"value"];
  }
  
  return data;
}

@end