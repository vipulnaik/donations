<script>
    // Given a table cell, if the cell consists of a number, strip commas and
    // return the number as a string. Otherwise just return the cell text. This
    // is mainly useful when trying to sort a column.
    function stripCommas(node) {
        try {
            // Here we assume node is <td>, and the first child node is <a> on
            // a numerical cell
            var cellText = node.childNodes[0].innerHTML;
        }
        catch(err) { }
        // If the above fails, then try again assuming that node is <td> but
        // without <a>
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
        return node.innerText;
    }
</script>
