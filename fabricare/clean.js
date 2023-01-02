// Created by Grigore Stefan <g_stefan@yahoo.com>
// Public domain (Unlicense) <http://unlicense.org>
// SPDX-FileCopyrightText: 2022 Grigore Stefan <g_stefan@yahoo.com>
// SPDX-License-Identifier: Unlicense

messageAction("clean");

Shell.removeDirRecursively("output");
Shell.removeDirRecursively("temp");
Shell.removeDirRecursivelyForce("source");

