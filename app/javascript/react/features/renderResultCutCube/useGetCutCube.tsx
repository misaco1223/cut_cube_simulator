import { useState, useEffect } from "react";
import * as THREE from "three";
import { useAuth } from "../../contexts/AuthContext";

export const useGetCutCube = (id: string|undefined) => {
  const [glbUrl, setGlbUrl] = useState<string|null>(null);
  const [cutPoints, setCutPoints] = useState<THREE.Vector3[] | null>(null);
  const [title, setTitle] = useState<string|null>(null);
  const [memo, setMemo] = useState<string|null>(null);
  const [createdAt, setCreatedAt] = useState<string|null>(null);
  const [bookmarkId, setBookmarkId] = useState<string|null>(null);
  const [cutFaceName, setCutFaceName] = useState<string|null>(null);
  const [volumeRatio, setVolumeRatio] = useState<number|null>(null);
  const [edgeLength, setEdgeLength] = useState<number|null>(null);

  const loadCutCubeFromStorage = (id: string) => {
    const { isLoggedIn } = useAuth();
    if (!isLoggedIn) {
      const storedCutCubes = JSON.parse(localStorage.getItem("cutCube") || "[]");
  
      const targetCube = storedCutCubes.find((cutCube: any) => String(cutCube.id) === id);
  
      if (targetCube) {
        setGlbUrl(targetCube.glbUrl || null);
        setCutPoints(targetCube.cutPoints || []);
        setTitle(targetCube.title || null);
        setMemo(targetCube.memo || null);
        setCutFaceName(targetCube.cutFaceName || null);
        setVolumeRatio(targetCube.volumeRatio || null);
        setEdgeLength(targetCube.edgeLength ||  null);
      }
    }
  };

  useEffect(() => {
    const fetchCutCube = async (id: string | undefined) => {
      if (!id) return;
      try {
        const response = await fetch(`/api/cut_cubes/${id}`, {
          method: "GET",
          headers: { "Content-Type": "application/json" },
          credentials: "include",
        });

        if (!response.ok) throw new Error("通信に失敗しました");

        const data = await response.json();
        if (data.cut_cube) {
          setGlbUrl(data.cut_cube.glb_url);
          const transformedPoints = data.cut_cube.cut_points.map((point: number[]) => {
            return new THREE.Vector3(
              point[0],
              point[2],
              -point[1]
            );
          });
          setCutPoints(transformedPoints);
          setTitle(data.cut_cube.title);
          setMemo(data.cut_cube.memo);
          setCreatedAt(data.cut_cube.created_at);
          setBookmarkId(data.bookmark_id);
          setCutFaceName(data.cut_cube.cut_face_name);
          setVolumeRatio(data.cut_cube.volume_ratio);
          setEdgeLength(data.cut_cube.edge_length);
        }
      } catch (error) {
        // console.error("cut_cubeの取得に失敗しました", error);
        loadCutCubeFromStorage(id);
      }
    };

    fetchCutCube(id);
  }, [id]);

  return { glbUrl, cutPoints, title, memo, createdAt, bookmarkId, setBookmarkId, cutFaceName, setCutFaceName, volumeRatio, edgeLength, setEdgeLength};
};
