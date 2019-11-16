//
//  MarkdiumTypes.h
//  Markdium
//
//  Created by v on 2019/11/16.
//  Copyright © 2019 lvv. All rights reserved.
//

#ifndef MarkdiumTypes_h
#define MarkdiumTypes_h

#import <Foundation/Foundation.h>

typedef NSInteger MDNodeType;

extern const MDNodeType MDNodeTypeDocument;
extern const MDNodeType MDNodeTypeBlockQuote;
extern const MDNodeType MDNodeTypeList;
extern const MDNodeType MDNodeTypeItem;
extern const MDNodeType MDNodeTypeCodeBlock;
extern const MDNodeType MDNodeTypeHTMLBlock;
extern const MDNodeType MDNodeTypeCustomBlock;
extern const MDNodeType MDNodeTypeParagraph;
extern const MDNodeType MDNodeTypeHeading;
extern const MDNodeType MDNodeTypeHeader;
extern const MDNodeType MDNodeTypeThematicBreak;
extern const MDNodeType MDNodeTypeHRule;
extern const MDNodeType MDNodeTypeText;
extern const MDNodeType MDNodeTypeSoftBreak;
extern const MDNodeType MDNodeTypeLineBreak;
extern const MDNodeType MDNodeTypeCode;
extern const MDNodeType MDNodeTypeHTMLInline;
extern const MDNodeType MDNodeTypeCustomInline;
extern const MDNodeType MDNodeTypeEmph;
extern const MDNodeType MDNodeTypeStrong;
extern const MDNodeType MDNodeTypeLink;
extern const MDNodeType MDNodeTypeImage;

#endif /* MarkdiumTypes_h */
