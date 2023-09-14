package tests;

import scribus.ScMarkdownConverter;
import buddy.BuddySuite;

using buddy.Should;

// https://github.com/ciscoheat/buddy
class TestScMarkdownConverter extends BuddySuite {
	public function new() {
		// https://api.haxe.org/StringTools.html#htmlEscape
		describe("convert mardown to htmlescape from markdown file", {
			it("should convert to xml with quote styling", {
				var md = 'htmlEscape special chars: &,<,>,",\'';
				var str = new ScMarkdownConverter(md).out;
				str.should.be('<ITEXT CH="htmlEscape special chars: &amp;,&lt;,&gt;,&quot;,&#039;"/>\n<para PARENT=""/>');
			});
		});

		// A test suite:
		describe("Extract headings from markdown file", {
			it("should convert to xml with heading 1 styling", {
				var str = new ScMarkdownConverter("# heading").out;
				str.should.be('<ITEXT CH="heading"/>\n<para PARENT="Text3_Heading 1"/>');
			});
			it("should convert to xml with heading 2 styling", {
				var str = new ScMarkdownConverter('## heading 2').out;
				str.should.be('<ITEXT CH="heading 2"/>\n<para PARENT="Text3_Heading 2"/>');
			});
		});

		describe("Extract bold from markdown file", {
			it("should convert to xml with bold styling", {
				var md = 'hallo, ik ben **bold** en niet jij';
				var str = new ScMarkdownConverter(md).out;
				str.should.be('<ITEXT CH="hallo, ik ben "/>\n<ITEXT CPARENT="Text5_Bold" CH="bold"/>\n<ITEXT CH=" en niet jij"/>\n<para PARENT=""/>');
			});
		});

		describe("Extract italic from markdown file", {
			it("should convert to xml with italic styling", {
				var md = 'hallo, ik ben _italic_ en niet jij';
				var str = new ScMarkdownConverter(md).out;
				str.should.be('<ITEXT CH="hallo, ik ben "/>\n<ITEXT CPARENT="Text5_Italic" CH="italic"/>\n<ITEXT CH=" en niet jij"/>\n<para PARENT=""/>');
			});
		});

		describe("Extract bold/italic from markdown file", {
			it("should convert to xml with bold/italic styling", {
				// var md = 'hallo, ik ben **_bold/italic_** en niet jij';
				// var str = new ScMarkdownConverter(md).out;
				// // str.should.be('<ITEXT CH="hallo, ik ben "/>\n<ITEXT CPARENT="Text5_Italic" CH="italic"/>\n<ITEXT CH=" en niet jij"/>\n<para PARENT=""/>');
			});
		});

		describe("Extract italic/bold from markdown file", {
			it("should convert to xml with italic/bold styling", {
				// var md = 'hallo, ik ben _**italic/bold**_ en niet jij';
				// var str = new ScMarkdownConverter(md).out;
				// // str.should.be('<ITEXT CH="hallo, ik ben "/>\n<ITEXT CPARENT="Text5_Italic" CH="italic"/>\n<ITEXT CH=" en niet jij"/>\n<para PARENT=""/>');
			});
		});

		describe("Extract blockquote from markdown file", {
			it("should convert to xml with quote styling", {
				var md = '> dit is een quote';
				var str = new ScMarkdownConverter(md).out;
				str.should.be('"<ITEXT CH="dit is een quote"/>\n<para PARENT="STYLE FOR QUOTE"/>');
			});
		});
	}
}
