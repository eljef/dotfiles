#!/usr/bin/python3
# Copyright (c) 2020-2024, Jef Oliver
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
# SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR
# IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
# SPDX-License-Identifier: 0BSD
#
# Authors:
# Jef Oliver <jef@eljef.me>
"""Get weather information to use in Conky."""

import argparse
import errno
import os
import requests


# Openweathermap API key
_API_KEY = ''
# City to retrieve weather info for
_CITY = ''
# Weather Unit Symbol (C/F)
_UNIT_SYMBOL = 'F'
# Units type to pull weather in (standard, metric, or imperial)
_UNITS = 'imperial'

# ******************************************************************************
# Main Functionality Below
# ******************************************************************************

# CLI Arguments
# Description
_C_DESC = 'Conky Weather Script.'
# Path Flag
_C_FLAG = '-p'
# Path Attribute name
_C_PATH = 'conky_path'

# Data directory
_DATA_DIR = 'data'
# Humidity data file
_DATA_HUMID = 'data/w_humid'
# Icon data file
_DATA_ICON = 'data/w_icon'
# Temperature data file
_DATA_TEMP = 'data/w_temp'

# File Operations
# Encoding
_F_ENC = 'utf8'
# Write Mode
_F_WRITE = 'w'

# Symbols
# Humidity Symbol
_S_HUM = "%"
# Temperature Symbol
_S_TEMP = "°"

# OpenWeatherMap API Base URL
_URL_BASE = 'https://api.openweathermap.org/data/2.5/weather'
# API Key Arg
_URL_API = 'appid'
# City Arg
_URL_CITY = 'q'
# Units Arg
_URL_UNITS = 'units'

# Dictionary key names
# Return code key
_W_CODE = 'cod'
# Humidity key
_W_HUMID = 'humidity'
# Icon key
_W_ICON = 'icon'
# Main key
_W_MAIN = 'main'
# Temperature key
_W_TEMP = 'temp'
# Weather key
_W_WEATHER = 'weather'


class Weather:
    """Operations cass to save weather data for conky."""
    def __init__(self, conky_dir: str) -> None:
        """Initialize the Weather object.
        Args:
            conky_dir (str): The configuration directory for conky
        """
        self._conky_dir = conky_dir
        self._w_data = {}

    def create_data_dir(self) -> None:
        """Creates the weather data directory under the conky directory."""
        try:
            os.mkdir(os.path.join(self._conky_dir, _DATA_DIR))
        except OSError as e:
            if e.errno != errno.EEXIST:
                raise e

    def get_current(self) -> bool:
        """Retrieves the current weather data from OpenWeatherMap.

        Returns:
            bool: True if the weather data is available, False otherwise.
        """
        full_url = f"{_URL_BASE}?{_URL_API}={_API_KEY}&{_URL_UNITS}={_UNITS}&{_URL_CITY}={_CITY}"
        response = requests.get(full_url, timeout=10)
        if response.ok:
            w_data = response.json()
            if _W_CODE in w_data and w_data[_W_CODE] == 200:
                self._w_data = w_data
                return True
        return False

    def save_humidity(self) -> None:
        """Saves humidity information for conky."""
        if _W_MAIN in self._w_data and _W_HUMID in self._w_data[_W_MAIN]:
            with open(os.path.join(self._conky_dir, _DATA_HUMID), _F_WRITE, encoding=_F_ENC) as f:
                f.write(f"{int(self._w_data[_W_MAIN][_W_HUMID])}{_S_HUM}".strip())

    def save_icon(self) -> None:
        """Saves icon name for conky."""
        if _W_WEATHER in self._w_data and len(self._w_data[_W_WEATHER]) > 0 and _W_ICON in self._w_data[_W_WEATHER][0]:
            with open(os.path.join(self._conky_dir, _DATA_ICON), _F_WRITE, encoding=_F_ENC) as f:
                f.write(self._w_data[_W_WEATHER][0][_W_ICON].strip())

    def save_temp(self) -> None:
        """Saves temperature information for conky."""
        if _W_MAIN in self._w_data and _W_TEMP in self._w_data[_W_MAIN]:
            with open(os.path.join(self._conky_dir, _DATA_TEMP), _F_WRITE, encoding=_F_ENC) as f:
                f.write(f"{int(self._w_data[_W_MAIN][_W_TEMP])}{_S_TEMP}{_UNIT_SYMBOL}".strip())


def _arg_parse() -> str:
    """Parses command line arguments.

    Returns:
        str: The parsed path to the conky configuration directory.
    """
    parser = argparse.ArgumentParser(description=_C_DESC)
    parser.add_argument(_C_FLAG, dest=_C_PATH, type=str, required=True)
    args = parser.parse_args()

    return getattr(args, _C_PATH)


def main() -> None:
    """Main functionality."""
    conky_path = _arg_parse()
    weather = Weather(conky_path)
    if weather.get_current():
        weather.create_data_dir()
        weather.save_humidity()
        weather.save_icon()
        weather.save_temp()


if __name__ == '__main__':
    main()
