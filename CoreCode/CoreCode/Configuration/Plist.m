//
//  NSObject+Settings.m
//  CivilizedConstruction
//
//  Created by  rtsafe02 on 12-8-22.
//  Copyright (c) 2012年  rtsafe02. All rights reserved.
//

#import "Plist.h"

@implementation Plist

//-(id) initWithFileName:(NSString *)fileName
//{
//    self = [super init];
//    if(self)
//    {
//         plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
//         dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//    }
//    return self;
//}
//
//-(NSString *)GetValue:(NSString *)sectionName
//{
//    return [dictionary valueForKeyPath:sectionName];
//}
//
//-(NSString *) GetValueByPath:(NSString *)path
//{
//    return [dictionary valueForKeyPath:path];
//}
//
//-(void)SetValue:(NSString *)sectionValue SectionPath:(NSString *)sectionPath
//{
//    [dictionary setValue:sectionValue forKeyPath:sectionPath];
//    
//    if (![dictionary writeToFile:plistPath atomically:YES]) {
//        
//        NSLog(@"Write %@ File Error!",plistPath);
//        
//    }
//}
//
//-(void)SetValue:(NSString *)sectionValue SectionName:(NSString *)sectionName
//{
//    [dictionary setValue:sectionValue forKey:sectionName];
//  
//    if (![dictionary writeToFile:plistPath atomically:YES]) {
//    
//        NSLog(@"Write %@ File Error!",plistPath);
//    
//    }
//    
//}

+(NSString *) GetValue:(NSString *)fileName Path:(NSString *)path
{
    //NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    //NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSMutableDictionary *dictionary = [ NSMutableDictionary dictionaryWithContentsOfFile:fileName]; 
    return [dictionary valueForKeyPath:path];
}
+(void)SetValue:(NSString *)fileName SectionPath:(NSString *)sectionPath SectionValue:(NSString *)sectionValue
{
    //NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
    //NSMutableDictionary *dictionary = [ [ NSMutableDictionary alloc ] init ];
    
    [dictionary setValue:sectionValue forKeyPath:sectionPath];
    

    if (![dictionary writeToFile:fileName atomically:YES]) {
        
        NSLog(@"Write %@ File Error!",fileName);
        
    }
}
@end
