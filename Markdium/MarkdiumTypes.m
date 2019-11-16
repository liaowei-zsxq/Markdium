//
//  MarkdiumTypes.h
//  Markdium
//
//  Created by v on 2019/11/16.
//  Copyright © 2019 lvv. All rights reserved.
//

#import "MarkdiumTypes.h"

const MDOptions MDOptionDefault = CMARK_OPT_DEFAULT;
const MDOptions MDOptionSourcePos = CMARK_OPT_SOURCEPOS;
const MDOptions MDOptionHardBreaks = CMARK_OPT_HARDBREAKS;
const MDOptions MDOptionSafe = CMARK_OPT_SAFE;
const MDOptions MDOptionUnsafe = CMARK_OPT_UNSAFE;
const MDOptions MDOptionNoBreaks = CMARK_OPT_NOBREAKS;
const MDOptions MDOptionValidateUTF8 = CMARK_OPT_VALIDATE_UTF8;
const MDOptions MDOptionSmart = CMARK_OPT_SMART;
const MDOptions MDOptionGithubPreLang = CMARK_OPT_GITHUB_PRE_LANG;
const MDOptions MDOptionLiberalHTMLTag = CMARK_OPT_LIBERAL_HTML_TAG;
const MDOptions MDOptionFootnotes = CMARK_OPT_FOOTNOTES;
const MDOptions MDOptionStrikethroughDoubleTilde = CMARK_OPT_STRIKETHROUGH_DOUBLE_TILDE;
const MDOptions MDOptionTablePreferStyleAttributes = CMARK_OPT_TABLE_PREFER_STYLE_ATTRIBUTES;
const MDOptions MDOptionFullInfoString = CMARK_OPT_FULL_INFO_STRING;

const MDExtensions MDExtensionNone = 0;
const MDExtensions MDExtensionTagFilter = (1 << 1);
const MDExtensions MDExtensionAutolink = (1 << 2);
const MDExtensions MDExtensionStrikethrough = (1 << 3);
const MDExtensions MDExtensionTasklist = (1 << 4);
const MDExtensions MDExtensionTable = (1 << 5);
const MDExtensions MDExtensionAll = MDExtensionTagFilter | MDExtensionAutolink | MDExtensionStrikethrough |
                                    MDExtensionTasklist | MDExtensionTable;

const MDNodeType MDNodeTypeDocument = NODE_DOCUMENT;
const MDNodeType MDNodeTypeBlockQuote = NODE_BLOCK_QUOTE;
const MDNodeType MDNodeTypeList = NODE_LIST;
const MDNodeType MDNodeTypeItem = NODE_ITEM;
const MDNodeType MDNodeTypeCodeBlock = NODE_CODE_BLOCK;
const MDNodeType MDNodeTypeHTMLBlock = NODE_HTML_BLOCK;
const MDNodeType MDNodeTypeCustomBlock = NODE_CUSTOM_BLOCK;
const MDNodeType MDNodeTypeParagraph = NODE_PARAGRAPH;
const MDNodeType MDNodeTypeHeading = NODE_HEADING;
const MDNodeType MDNodeTypeHeader = NODE_HEADER;
const MDNodeType MDNodeTypeThematicBreak = NODE_THEMATIC_BREAK;
const MDNodeType MDNodeTypeHRule = NODE_HRULE;
const MDNodeType MDNodeTypeText = NODE_TEXT;
const MDNodeType MDNodeTypeSoftBreak = NODE_SOFTBREAK;
const MDNodeType MDNodeTypeLineBreak = NODE_LINEBREAK;
const MDNodeType MDNodeTypeCode = NODE_CODE;
const MDNodeType MDNodeTypeHTMLInline = NODE_HTML_INLINE;
const MDNodeType MDNodeTypeCustomInline = NODE_CUSTOM_INLINE;
const MDNodeType MDNodeTypeEmph = NODE_EMPH;
const MDNodeType MDNodeTypeStrong = NODE_STRONG;
const MDNodeType MDNodeTypeLink = NODE_LINK;
const MDNodeType MDNodeTypeImage = NODE_IMAGE;
