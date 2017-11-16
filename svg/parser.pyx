from nanosvg cimport (NSVGimage, nsvgParse, nsvgParseFromFile)


class SVGParserError(Exception):
    pass


def _dpi_conv(dpi: str):
    units = dpi[-2:].encode('UTF-8')
    _dpi = float(dpi[:-2])
    return units, _dpi


cdef class Parser:
    """
    Cython class for parsing SVG files.
    """

    @staticmethod
    def parse(svg: str, dpi: str = '96px') -> SVG:
        """
        Creates an SVG image from an SVG string. Units for dpi are 'px', 'pt',
        'pc' 'mm', 'cm', or 'in'.
        """
        units, magnitude = _dpi_conv(dpi)
        im = SVG()
        im._nsvgimage = nsvgParse(svg.encode('UTF-8'), units, magnitude)
        if im._nsvgimage == NULL:
            raise SVGParserError("Could not parse SVG from string.")
        else:
            return im

    @staticmethod
    def parse_file(filename: str, dpi: str = '96px') -> SVG:
        """
        Creates an SVG image from filename. Units for dpi are 'px', 'pt',
        'pc' 'mm', 'cm', or 'in'.
        """
        file = filename.encode('UTF-8')
        units, magnitude = _dpi_conv(dpi)
        im = SVG()
        im._nsvgimage = nsvgParseFromFile(file, units, magnitude)
        if im._nsvgimage == NULL:
            raise SVGParserError(
                "Could not parse SVG from {}".format(filename)
                )
        else:
            return im
