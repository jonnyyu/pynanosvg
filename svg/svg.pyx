cdef class SVG:
    """Cython for parsing and getting information about an SVG"""
    cdef NSVGimage* _nsvgimage

    def __cinit__(self):
        self._nsvgimage = NULL

    def __dealloc__(self):
        if self._nsvgimage != NULL:
            nsvgDelete(self._nsvgimage)

    @property
    def width(self):
        """Returns the width of the svg image."""
        if self._nsvgimage == NULL:
            raise ValueError("SVG has not been parsed yet.")
        return self._nsvgimage.width

    @property
    def height(self):
        """Returns the height of the svg image."""
        if self._nsvgimage == NULL:
            raise ValueError("SVG has not been parsed yet.")
        return self._nsvgimage.height