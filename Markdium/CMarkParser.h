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

void cmarkEnableGFM(cmark_parser *parser);

cmark_node *cmarkParseString(NSString *string, int options, BOOL gfm);
