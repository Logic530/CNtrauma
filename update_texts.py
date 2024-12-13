#!/usr/bin/python
# -*- coding: UTF-8 -*-

import xml.sax
from pathlib import Path
import xml.sax.xmlreader

xliff_head_en = """\
<?xml version="1.0" encoding="UTF-8"?>
<xliff xmlns="urn:oasis:names:tc:xliff:document:1.2" version="1.2">
<file source-language="en" target-language="en" datatype="plaintext">
<body>"""

xliff_head_cn = """\
<?xml version="1.0" encoding="UTF-8"?>
<xliff xmlns="urn:oasis:names:tc:xliff:document:1.2" version="1.2">
<file source-language="en" target-language="cn" datatype="plaintext">
<body>"""

xliff_end = """\
</body>
</file>
</xliff>
"""

xliff_unit = """\
<trans-unit id="{}">
<source>{}</source>
<target>{}</target>
</trans-unit>
"""

working_path = Path(__file__).parent

official_en_path = working_path / "Texts" / "English"
official_cn_path = working_path / "Texts" / "SimplifiedChinese"
en_path = working_path / "en"
cn_path = working_path / "cn"


class TextsHandler(xml.sax.ContentHandler):
    def __init__(self, output):
        self.key = ""
        self.text = ""
        self.src_lang = ""
        self.tar_lang = ""
        self.tag_records = {}
        self.outfile = open(output, "w", encoding="UTF-8")

    # 元素开始事件处理
    def startElement(self, tag: str, attributes: xml.sax.xmlreader.AttributesImpl):
        if tag == "infotexts":
            self.tar_lang = attributes["language"]
            if self.tar_lang == "English":
                self.outfile.write(xliff_head_en)
            elif self.tar_lang == "Simplified Chinese":
                self.outfile.write(xliff_head_cn)
            else:
                raise "unsupported language"
        else:
            if tag in self.tag_records:
                self.key = tag + ".cid" + str(self.tag_records[tag])
                self.tag_records[tag] = self.tag_records[tag] + 1
            else:
                self.tag_records[tag] = 1
                self.key = tag
        pass

    # 元素结束事件处理
    def endElement(self, tag):
        if tag == "infotexts":
            self.outfile.write(xliff_end)
            self.outfile.close()
        else:
            if self.tar_lang == "English":
                self.outfile.write(xliff_unit.format(self.key, self.text, self.text))
            elif self.tar_lang == "Simplified Chinese":
                self.outfile.write(xliff_unit.format(self.key, "", self.text))

    # 内容事件处理
    def characters(self, content):
        self.text = content
        pass


if __name__ == "__main__":
    assert cn_path.exists()
    assert official_en_path.exists()
    assert official_cn_path.exists()
    assert en_path.exists()

    for file in list(official_en_path.glob("**/*.xml")):
        outfile = (
            en_path.as_posix()
            + "/"
            + (file.name).removeprefix("English").removesuffix(".xml")
            + ".xliff"
        )
        parser = xml.sax.make_parser()
        textshandler = TextsHandler(outfile)
        parser.setContentHandler(textshandler)
        parser.parse(file.as_posix())
        pass

    for file in list(official_cn_path.glob("**/*.xml")):
        outfile = (
            cn_path.as_posix()
            + "/"
            + (file.name).removeprefix("SimplifiedChinese").removesuffix(".xml")
            + ".xliff"
        )
        parser = xml.sax.make_parser()
        textshandler = TextsHandler(outfile)
        parser.setContentHandler(textshandler)
        parser.parse(file.as_posix())
        pass
