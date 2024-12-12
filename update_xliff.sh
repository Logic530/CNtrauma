SCRIPTPATH=$(dirname "$SCRIPT")

ST_XSLT_PATH="${SCRIPTPATH}/xml2xliff_st.xslt"
XT_XSLT_PATH="${SCRIPTPATH}/xml2xliff_xt.xslt"
SORT_XSLT_PATH="${SCRIPTPATH}/xml_sort.xslt"

LANGUAGE_PREFIX='English'
LANGUAGE_PREFIX_SHORT='en'

for file in $(ls ${SCRIPTPATH}/Texts/${LANGUAGE_PREFIX}/); do
    OUTPUT=${file#$LANGUAGE_PREFIX}
    OUTPUT=${OUTPUT%.xml}.xliff

    xsltproc ${SORT_XSLT_PATH} ${SCRIPTPATH}/Texts/${LANGUAGE_PREFIX}/${file} | xsltproc ${ST_XSLT_PATH} - | xmllint --format --encode UTF-8 - >${SCRIPTPATH}/${LANGUAGE_PREFIX_SHORT}/${OUTPUT}
done

LANGUAGE_PREFIX='SimplifiedChinese'
LANGUAGE_PREFIX_SHORT='cn'
for file in $(ls ${SCRIPTPATH}/Texts/${LANGUAGE_PREFIX}/); do
    OUTPUT=${file#$LANGUAGE_PREFIX}
    OUTPUT=${OUTPUT%.xml}.xliff
    xsltproc ${SORT_XSLT_PATH} ${SCRIPTPATH}/Texts/${LANGUAGE_PREFIX}/${file} | xsltproc ${XT_XSLT_PATH} - | xmllint --format --encode UTF-8 - >${SCRIPTPATH}/${LANGUAGE_PREFIX_SHORT}/${OUTPUT}
done
