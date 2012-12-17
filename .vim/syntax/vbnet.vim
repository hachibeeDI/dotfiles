" Vim syntax file
" Modified from the default syntax/vb.vim
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

syn keyword vbStatement Auto Ansi Assembly Declare Lib
syn keyword vbStatement Const Continue Custom
syn keyword vbStatement Default
syn keyword vbStatement Dim As DirectCast
syn keyword vbStatement Event Error
syn keyword vbStatement RaiseEvent
syn keyword vbStatement Step Stop
syn keyword vbStatement SyncLock
syn keyword vbStatement TypeOf
syn keyword vbStatement Unicode Variant When

syn keyword vbTypes Boolean Byte Char Date Decimal Double
syn keyword vbTypes Integer Long Object Short Single String
syn keyword vbTypes UInteger ULong UShort SByte
syn keyword vbTypes List Dictionary IEnumerable IObservable

syn match vbOperator "[()+\-/*=&]"
syn match vbOperator "[<>]=\="
syn match vbOperator "<>"
syn match vbOperator "\s\+_$"
" {{{
syn keyword vbStorage Delegate Namespace
syn keyword vbTypeDef Class Interface
syn match vbTypeDefEnd "End \(Class\|Interface\)$"

syn keyword vbStructure Structure Enum Module
syn match vbStructureEnd "End \(Structure\|Enum\|Module\)$"

syn keyword vbRepeat For Each Return While Next To
syn keyword vbConditional If Then Else ElseIf "Select Case" Case
syn match vbConditionalEnd "End \(If\|Select\)$"

syn keyword vbModifier Inherits Implements MustInherit MustOverride Const Overrides Overridable Overloads Readonly WriteOnly Shared NotInheritable NotOverridable Shadows
syn keyword vbFunction Sub Function
syn match vbFunction "End \(Function\|Sub\)$"

syn keyword vbScopeDecl Private Protected Public Friend Using

syn keyword vbSpecial MyBase MyClass Of Call
syn keyword vbSugar With AddHandler AddressOf Alias WithEvents RemoveHandler Handles
syn match vbDefAnonymous "New \(With$\|With {$\)"

syn keyword vbProperty Property Get Set
syn match vbPropertyEnd "^\s*End \(Get\|Set\|Property\)$"

syn keyword vbKeyword ByVal ByRef GetType ParamArray On Option Optional Exit
syn keyword vbException Try Catch Finally Throw
syn keyword vbOperator New And Or AndAlso OrElse Is Not IsNot Like Mod
syn keyword vbBoolean True False
syn match vbDelimiter "\(,\|\.\|:\|{\|}\)"
syn keyword vbDeprecated Do Until Loop Goto Redim GoSub Resume Erase Preserve
"}}}

syn keyword vbConst Me Nothing

syn keyword vbTodo contained TODO

"integer number, or floating point number without a dot.
syn match vbNumber "\<\d\+\>"
"floating point number, with dot
syn match vbNumber "\<\d\+\.\d*\>"
"floating point number, starting with a dot
syn match vbNumber "\.\d\+\>"

" String and Character contstants
syn region vbString start=+"+ end=+"+

syn region vbComment start="\<REM\>" end="$" contains=vbTodo
syn region vbComment start="'" end="$" contains=vbTodo

syn region vbPreCondit start="^#If\s" end="Then$"
syn region vbPreCondit start="^#ElseIf\s" end="Then$"
syn match vbPreCondit "^#Else$"
syn match vbPreCondit "^#End If$"

syn region vbPreCondit start="^#Region\s\+\"" end="\"$"
syn match vbPreCondit "^#End Region$"

syn region vbPreCondit start="^#ExternalSource(" end=")$"
syn match vbPreCondit "^#End ExternalSource$"

syn region vbPreCondit start="^#Const\s" end="$"

syn region vbLineNumber  start="^\d" end="\s"

syn match vbTypeSpecifier "[a-zA-Z0-9][\$%&!#]"ms=s+1


"" xml literals {{{
"syn match vbXmlTag "<[a-zA-Z]\_[^>]*/>" contains=vbXmlQuote,vbXmlEscape,vbXmlString
"syn region vbXmlString start="\"" end="\"" contained
"syn match vbXmlStart "<[a-zA-Z]\_[^>]*>" contained contains=vbXmlQuote,vbXmlEscape,vbXmlString
"syn region vbXml start="<\([a-zA-Z]\_[^>]*\_[^/]\|[a-zA-Z]\)>" matchgroup=vbXmlStart end="</\_[^>]\+>" contains=vbXmlEscape,vbXmlQuote,vbXml,vbXmlStart,vbXmlComment
"syn region vbXmlEscape matchgroup=vbXmlEscapeSpecial start="<%=" matchgroup=vbXmlEscapeSpecial end="%>" contained contains=TOP
"syn match vbXmlQuote "&[^;]\+;" contained
"syn match vbXmlComment "<!--\_[^>]*-->" contained
"" }}}

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_vbnet_syntax_inits")
    let did_vbnet_syntax_inits = 1

    hi link vbLineNumber Comment
    hi link vbNumber Number
    hi link vbConst Constant
    hi link vbRepeat Repeat
    hi link vbConditional Conditional
    hi link vbConditionalEnd Conditional
    hi link vbKeyword Keyword
    hi link vbStorage StorageClass
    hi link vbModifier vbStorage
    hi link vbScopeDecl vbStorage
    hi link vbTypeDef TypeDef
    hi link vbTypeDefEnd TypeDef
    hi link vbStructure Structure
    hi link vbStructureEnd Structure
    hi link vbError Error
    hi link vbStatement Statement
    hi link vbString String
    hi link vbComment Comment
    hi link vbTodo Todo
    hi link vbFunction Function
    hi link vbMethods PreProc
    hi link vbPreCondit PreCondit
    hi link vbSpecial Special
    hi link vbSugar vbSpecial
    hi link vbDefAnonymous vbSpecial
    hi link vbProperty vbSugar
    hi link vbPropertyEnd vbSugar
    hi link vbTypeSpecifier Type
    hi link vbTypes Type
    hi link vbOperator Operator
    hi link vbDelimiter Delimiter
    hi link vbDeprecated Error

"    hi link vbXml String
"    hi link vbXmlTag Include
"    hi link vbXmlString String
"    hi link vbXmlStart Include
"    hi link vbXmlEscape Normal
"    hi link vbXmlEscapeSpecial Special
"    hi link vbXmlQuote Special
"    hi link vbXmlComment Comment
endif

let b:match_words = '\<Namespace\>:\<End Namespace\>'
      \ . ',\<Module\>:\<End Module\>'
      \ . ',\<Class\>:\<End Class\>'
      \ . ',\<Property\>:\<End Property\>'
      \ . ',\<Enum\>:\<End Enum\>'
      \ . ',\<Function\>:\<End Function\>'
      \ . ',\<Sub\>:\<End Sub\>'
      \ . ',\<Get\>:\<End Get\>'
      \ . ',\<Set\>:\<End Set\>'
      \ . ',\<Do\>:\<Loop\>'
      \ . ',\<For\>:\<Next\>'
      \ . ',\<While\>:\<End While\>'
      \ . ',\<Select\>:\<End Select\>'
      \ . ',\<Using\>:\<End Using\>'
      \ . ',\<With\>:\<End With\>'
      \ . ',\<SyncLock\>:\<End SyncLock\>'
      \ . ',\<Try\>:\<End Try\>'
      \ . ',\<If\>:\<End If\>'
let b:current_syntax = "vbnet"
