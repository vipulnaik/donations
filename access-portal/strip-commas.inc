<script>
    function stripCommas(node) {
        // node is <td>, and the first child node is <a> on a numerical
        // cell, so cellText should just be a string representation of
        // the number in the cell
        var cellText = node.childNodes[0].innerHTML;
        // Check if a number
        if (cellText && cellText[0] >= "0" && cellText[0] <= "9") {
            return cellText.replace(/,/g, "");;
        }
        // return node.childNodes[0].childNodes[0].innerHTML.replace(/,/g, "");
        var c = node.innerHTML;
        console.log(c);
        return c;
    }
</script>
