 var getLocalization = function () {
    var localization = null;
    localization =
    {
        // separator of parts of a date (e.g. '/' in 11/05/1955)
        '/': "/",
        // separator of parts of a time (e.g. ':' in 05:44 PM)
        ':': ":",
        // the first day of the week (0 = Sunday, 1 = Monday, etc)
        firstDay: 0,
        days: {
            // full day names
            names: ["Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado"],
            // abbreviated day names
            namesAbbr: ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"],
            // shortest day names
            namesShort: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"]
        },
        months: {
            // full month names (13 months for lunar calendards -- 13th month should be "" if not lunar)
            names: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre", ""],
            // abbreviated month names
            namesAbbr: ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic", ""]
        },
        // AM and PM designators in one of these forms:
        // The usual view, and the upper and lower case versions
        //      [standard,lowercase,uppercase]
        // The culture does not use AM or PM (likely all standard date formats use 24 hour time)
        //      null
        AM: ["AM", "am", "AM"],
        PM: ["PM", "pm", "PM"],
        eras: [
        // eras in reverse chronological order.
        // name: the name of the era in this culture (e.g. A.D., C.E.)
        // start: when the era starts in ticks (gregorian, gmt), null if it is the earliest supported era.
        // offset: offset in years from gregorian calendar
        { "name": "A.D.", "start": null, "offset": 0 }
        ],
        twoDigitYearMax: 2029,
        patterns: {
            // short date pattern
            d: "M/d/yyyy",
            // long date pattern
            D: "dddd, MMMM dd, yyyy",
            // short time pattern
            t: "h:mm tt",
            // long time pattern
            T: "h:mm:ss tt",
            // long date, short time pattern
            f: "dddd, MMMM dd, yyyy h:mm tt",
            // long date, long time pattern
            F: "dddd, MMMM dd, yyyy h:mm:ss tt",
            // month/day pattern
            M: "MMMM dd",
            // month/year pattern
            Y: "yyyy MMMM",
            // S is a sortable format that does not vary by culture
            S: "yyyy\u0027-\u0027MM\u0027-\u0027dd\u0027T\u0027HH\u0027:\u0027mm\u0027:\u0027ss",
            // formatting of dates in MySQL DataBases
            ISO: "yyyy-MM-dd hh:mm:ss",
            ISO2: "yyyy-MM-dd HH:mm:ss",
            d1: "dd.MM.yyyy",
            d2: "dd-MM-yyyy",
            d3: "dd-MMMM-yyyy",
            d4: "dd-MM-yy",
            d5: "H:mm",
            d6: "HH:mm",
            d7: "HH:mm tt",
            d8: "dd/MMMM/yyyy",
            d9: "MMMM-dd",
            d10: "MM-dd",
            d11: "MM-dd-yyyy"
        },
        percentsymbol: "%",
        currencysymbol: "$",
        currencysymbolposition: "before",
        decimalseparator: '.',
        thousandsseparator: ',',
        pagergotopagestring: "Ir a página:",
        pagershowrowsstring: "Ver registros:",
        pagerrangestring: " de ",
        pagerpreviousbuttonstring: "anterior",
        pagernextbuttonstring: "siguiente",
        pagerfirstbuttonstring: "primero",
        pagerlastbuttonstring: "ultimo",
        groupsheaderstring: "Arrastre una columna y colóquela aquí para agrupar por esa columna",
        sortascendingstring: "Sorteo Ascendente",
        sortdescendingstring: "Serteo Descendente",
        sortremovestring: "Quitar Sorteo",
        groupbystring: "Agrupar por esta columna",
        groupremovestring: "Qutar de grupos",
        filterclearstring: "Limpiar",
        filterstring: "Filtro",
        filtershowrowstring: "Ver donde:",
        filterorconditionstring: "O",
        filterandconditionstring: "y",
        filterselectallstring: "(Seleccionar Todos)",
        filterchoosestring: "Elija:",
        filterstringcomparisonoperators: ['Vacio', 'no vacio', 'contener', 'contener(similar caso)',
           'sin contiener', 'sin contener(igual caso)', 'comienza con', 'comienza con(similar caso)',
           'termina con', 'termina con(similar caso)', 'igual', 'igual(similar caso)', 'nulo', 'no nulo'],
        filternumericcomparisonoperators: ['igual', 'no igual', 'menos que', 'menos que o igual', 'mayor que', 'mayor que o igual', 'nulo', 'no nulo'],
        filterdatecomparisonoperators: ['igual', 'no igual', 'menor que', 'menor que o igual', 'mayor que', 'mayor que o igual', 'nulo', 'no nulo'],
        filterbooleancomparisonoperators: ['igual', 'no igual'],
        validationstring: "Valor ingrsado invalido",
        emptydatastring: "No hay datos",
        filterselectstring: "Seleccionar Filtro",
        loadtext: "Cargando...",
        clearstring: "Limpiar",
        todaystring: "Hoy"
    };
    return localization;
};