#!/usr/bin/env python3
"""Remove zero-area degenerate specks that the Manifold engine can leave where a swept run overlaps a tangent arc
(2-face bodies of ~0 mm² area). Only detached bodies below --max-area are removed; real geometry is never touched.
Usage: stl_clean.py file.stl [--max-area 0.01]   Prints one line when something was removed."""
import sys, argparse
import numpy as np, trimesh
ap = argparse.ArgumentParser(); ap.add_argument("stl"); ap.add_argument("--max-area", type=float, default=0.01)
a = ap.parse_args()
m = trimesh.load(a.stl, force="mesh")
parts = m.split(only_watertight=False)
if len(parts) <= 1: sys.exit(0)
keep = [p for p in parts if p.area > a.max_area]
drop = len(parts) - len(keep)
if drop == 0 or not keep: sys.exit(0)
out = trimesh.util.concatenate(keep) if len(keep) > 1 else keep[0]
out.export(a.stl)
print(f"[stl_clean] {a.stl}: removed {drop} degenerate speck(s) (area <= {a.max_area} mm²), {len(keep)} body/bodies kept")
