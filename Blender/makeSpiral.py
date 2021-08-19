import bpy
import mathutils
import os
from math import radians
from csv import reader

scene = bpy.context.scene
dg = bpy.context.evaluated_depsgraph_get()

# Define Constants/snake-specs
PI = 3.1415
m_locs = [(1,0,0), (0,1,0), (-1,0,0), (0,-1,0)] #m_vecs actually
a = 1
m_a = a/4
h = 14
N_tot = 2

#creating muscle cross-section
bpy.ops.mesh.primitive_circle_add(radius=m_a, enter_editmode=False, align='WORLD', location=m_locs[0], scale=(1, 1, 1))
bpy.ops.mesh.primitive_circle_add(radius=m_a, enter_editmode=False, align='WORLD', location=m_locs[1], scale=(1, 1, 1))
bpy.ops.mesh.primitive_circle_add(radius=m_a, enter_editmode=False, align='WORLD', location=m_locs[2], scale=(1, 1, 1))
bpy.ops.mesh.primitive_circle_add(radius=m_a, enter_editmode=False, align='WORLD', location=m_locs[3], scale=(1, 1, 1))

#joining muscles
obs = []
for ob in scene.objects:
    if ob.type == 'MESH':
        obs.append(ob)

ctx = bpy.context.copy()
ctx['active_object'] = obs[0]
ctx['selected_editable_objects'] = obs
bpy.ops.object.join(ctx)
muscles = bpy.data.objects['Circle']

#give muscles a parent
base = bpy.data.objects.new("Parent", None)
bpy.context.collection.objects.link(base)
dg.update()

muscles.parent = base

#creating rotation axis
rot_ax = bpy.data.objects.new("RotAxis",None)
bpy.context.collection.objects.link(rot_ax)
dg.update()

#create Helix
helix = muscles.modifiers.new(name='Helix',type='SCREW')
helix.object = rot_ax
helix.screw_offset = h
helix.iterations = N_tot


#place cross-section (FROM MATLAB)
cur = "/Users/emmawaters/Documents/GitHub/HelixModel"
data = os.path.join(cur, "blenderData.csv")
with open(data, 'r') as read_obj:
    csv_reader = reader(read_obj)
    # Iterate over each row in the csv; updating cross-section and add keyframe
    old_rot = mathutils.Matrix.Identity(4)
    c = 1
    for line in csv_reader:
        theta_s = -1* float(line[0])
        x = float(line[1])
        y = float(line[2])
        p = float(line[3])
        
        if theta_s > 1.5:
            theta_s -= 1.5
            
        new_rot = mathutils.Matrix.Rotation(theta_s, 4, (x,y, 0))
        new_loc = mathutils.Matrix.Translation((x,y,0))

        # decompose world_matrix's components, and from them assemble 4x4 matrices
        orig_loc, orig_rot, orig_scale = base.matrix_world.decompose()
        orig_loc_mat = mathutils.Matrix.Translation(orig_loc)
        orig_rot_mat = orig_rot.to_matrix().to_4x4()
        orig_scale_mat = mathutils.Matrix.Scale(orig_scale[0],4,(1,0,0)) @ mathutils.Matrix.Scale(orig_scale[1],4,(0,1,0)) @ mathutils.Matrix.Scale(orig_scale[2],4,(0,0,1))

        # assemble the new matrix
        #base.matrix_world = new_loc @ new_rot @ old_rot @ orig_rot_mat @ orig_scale_mat
        base.matrix_world = new_loc @ orig_rot_mat @ orig_scale_mat
        old_rot = new_rot.inverted()
        
        helix.screw_offset = p

        base.keyframe_insert(data_path = "location", frame = c)
        base.keyframe_insert(data_path = "rotation_euler", frame = c)
        helix.keyframe_insert(data_path = "screw_offset", frame = c)
        c += 6
