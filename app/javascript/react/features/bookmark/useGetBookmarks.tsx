import { useState, useEffect } from "react";
import * as THREE from "three";
import toIntegerRatio from "../renderResultCutCube/useToIntegerRatio";

export const useGetBookmarks = () => {
  const [bookmarkIds, setBookmarkIds] = useState<string[]>([]);
  const [cutCubeIds, setCutCubeIds] = useState<string[]>([]);
  const [glbUrls, setGlbUrls] = useState<string[]>([]);
  const [cutPoints, setCutPoints] = useState<THREE.Vector3[][]>([]);
  const [titles, setTitles] = useState<string[]>([]);
  const [memos, setMemos] = useState<string[]>([]);
  const [createdAt, setCreatedAt] = useState<string[]>([]);
  const [isLoaded, setIsLoaded] = useState<boolean>(false);
  const [cutFaceNames, setCutFaceNames] = useState<string[]>([]);
  const [volumeRatios, setVolumeRatios] = useState<string[]>([]);

  const fetchCutCube = async () => {
    try {
      const response = await fetch(`/api/bookmarks`, {
        method: "GET",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
      });

      if (!response.ok) throw new Error("通信に失敗しました");

      const data = await response.json();
      if (data.bookmarks) {
        // console.log("bookmarkデータは,", data.bookmarks);
        setBookmarkIds(data.bookmarks.bookmark_ids);
        setCutCubeIds(data.bookmarks.cut_cube_ids);
        setGlbUrls(data.bookmarks.glb_urls);

        const transformedPoints = data.bookmarks.cut_points.map((points: number[][]) => {
          return points.map((point: number[]) => 
            new THREE.Vector3(point[0], point[2], -point[1]));
        });
        setCutPoints(transformedPoints);

        setTitles(data.bookmarks.titles);
        setMemos(data.bookmarks.memos);
        setCreatedAt(data.bookmarks.created_at);
        setCutFaceNames(data.bookmarks.cut_face_names);
        const transformedRatios = data.bookmarks.volume_ratios.map((ratio: number)=>{
          if (!ratio || ratio == 0) return;
          const a = ratio;
          const b = 1-ratio;
          const [r_1, r_2] = toIntegerRatio(a,b);
          return `${r_1} : ${r_2}`;
        })
        setVolumeRatios(transformedRatios);
        setIsLoaded(true);
      } else {
        // console.log("データなし");
      }
    } catch (error) {
      // console.error("bookmarkの取得に失敗しました", error);
    }
  };

  useEffect(() => {
    fetchCutCube();  
  }, []);

  return { bookmarkIds, cutCubeIds, glbUrls, cutPoints, createdAt, titles, memos, isLoaded, cutFaceNames, volumeRatios};
};