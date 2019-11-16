//
//  CMarkParser.h
//  Markdium
//
//  Created by v on 2019/11/16.
//  Copyright © 2019 lvv. All rights reserved.
//

#import <Foundation/Foundation.h>

void cmarkGFMCoreExtensionsEnsureRegistered(void);

NSString *getNodeTypeString(cmark_node *node);

NSString *getNodeLiteral(cmark_node *node);

cmark_node *cmarkParseString(NSString *string, int options, int extensions);
