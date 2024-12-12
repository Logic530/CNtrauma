SCRIPTPATH=$(dirname "$SCRIPT")

ST_XSLT_PATH="${SCRIPTPATH}/xml2xliff_st.xml"
XT_XSLT_PATH="${SCRIPTPATH}/xml2xliff_xt.xml"

LANGUAGE_PREFIX='English'
LANGUAGE_PREFIX_SHORT='en'

for file in $(ls ${SCRIPTPATH}/Texts/${LANGUAGE_PREFIX}/); do
    OUTPUT=${file#$LANGUAGE_PREFIX}
    OUTPUT=${OUTPUT%.xml}.xliff
    xsltproc ${ST_XSLT_PATH} ${SCRIPTPATH}/Texts/${LANGUAGE_PREFIX}/${file} |
        xmllint --format --encode UTF-8 - >${SCRIPTPATH}/${LANGUAGE_PREFIX_SHORT}/${OUTPUT}
done

LANGUAGE_PREFIX='SimplifiedChinese'
LANGUAGE_PREFIX_SHORT='cn'
for file in $(ls ${SCRIPTPATH}/Texts/${LANGUAGE_PREFIX}/); do
    OUTPUT=${file#$LANGUAGE_PREFIX}
    OUTPUT=${OUTPUT%.xml}.xliff
    xsltproc ${XT_XSLT_PATH} ${SCRIPTPATH}/Texts/${LANGUAGE_PREFIX}/${file} |
        xmllint --format --encode UTF-8 - >${SCRIPTPATH}/${LANGUAGE_PREFIX_SHORT}/${OUTPUT}
done
