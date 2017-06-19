<script>
    // Given a table cell, if the cell consists of a number, strip commas and
    // return the number as a string. Otherwise just return the cell HTML. This
    // is mainly useful when trying to sort a column.
    function stripCommas(node) {
        // node is <td>, and the first child node is <a> on a numerical
        // cell, so cellText should just be a string representation of
        // the number in the cell
        try {
            var cellText = node.childNodes[0].innerHTML;
        }
        catch(err) { }
        if (typeof cellText === 'undefined') {
            try {
                var cellText = node.innerHTML;
            }
            catch(err) { }
        }

        // Check if a number
        if (typeof cellText !== 'undefined' && (cellText[0] === "-" || (cellText[0] >= "0" && cellText[0] <= "9"))) {
            return cellText.replace(/,/g, "");
        }
        // return node.childNodes[0].childNodes[0].innerHTML.replace(/,/g, "");
        var c = node.innerHTML;
        // console.log(c);
        return c;
    }
</script>
