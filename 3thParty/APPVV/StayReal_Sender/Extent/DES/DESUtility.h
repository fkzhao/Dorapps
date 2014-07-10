//
//  DESUtility.h
//  Quartz
//
//  Created by Anselz on 13-7-25.
//  Copyright (c) 2013年 Anselz. All rights reserved.
//

/**示例代码
 NSString *url = [NSString stringWithFormat:@"http://beta.neoworkstudio.com/api.neoworkstudio.com/des_get.php?p=%@",[DESUtility encryptUseDES:@"Hello,I am 明文"]];
 NSString *newUrl = [url stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
 NSString* encrypt =[[NSString alloc]initWithContentsOfURL:[NSURL URLWithString: newUrl] encoding:NSUTF8StringEncoding error:nil];
 NSString* decrypt = encrypt;//[DESUtility decryptUseDES:encrypt];
 
 */

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Foundation/Foundation.h>

@interface DESUtility : NSObject

+ (NSString *) udid;
+ (NSString *) md5:(NSString *)str;
+ (NSString *) doCipher:(NSString *)sTextIn key:(NSString *)sKey context:(CCOperation)encryptOrDecrypt;
//加密
+ (NSString *) encryptStr:(NSString *) str;
//解密
+ (NSString *) decryptStr:(NSString *) str;
//PHP 解密
+(NSString*) decryptUseDES:(NSString*)cipherText;
+(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key;
//PHP 加密
+(NSString *) encryptUseDES:(NSString *)clearText;
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;

#pragma mark Based64
+ (NSString *) encodeBase64WithString:(NSString *)strData;
+ (NSString *) encodeBase64WithData:(NSData *)objData;
+ (NSData *) decodeBase64WithString:(NSString *)strBase64;

@end
