document.addEventListener("DOMContentLoaded", function () {

  /* =========================
     FOOTER YEAR
  ========================= */
  document.getElementById("year").innerText =
    new Date().getFullYear();


  /* =========================
     THEME TOGGLE
  ========================= */
  const body = document.body;
  const themeToggle = document.getElementById("themeToggle");
  const themeIcon = document.getElementById("themeIcon");

  const savedTheme =
    localStorage.getItem("theme") || "light";

  applyTheme(savedTheme);

  function toggleTheme() {
    const newTheme =
      body.classList.contains("dark-mode")
        ? "light"
        : "dark";

    applyTheme(newTheme);
    localStorage.setItem("theme", newTheme);
  }

  function applyTheme(theme) {

    if (theme === "dark") {
document.documentElement.setAttribute("data-theme", "dark");
      body.setAttribute("data-bs-theme", "dark");

      setIcon("dark");

    } else {

      body.classList.remove("dark-mode");
      body.setAttribute("data-bs-theme", "light");

      setIcon("light");
    }
  }

  function setIcon(theme) {

    if (theme === "dark") {

      themeIcon.classList.remove("bi-moon-fill");
      themeIcon.classList.add("bi-sun-fill");

    } else {

      themeIcon.classList.remove("bi-sun-fill");
      themeIcon.classList.add("bi-moon-fill");
    }
  }

  if (themeToggle) {

    themeToggle.addEventListener("click", function (e) {

      e.preventDefault();
      toggleTheme();

    });
  }


  /* =========================
     SIDEBAR SEARCH
  ========================= */
  const searchForm =
    document.getElementById("dashboardSearchForm");

  const searchInput =
    document.getElementById("dashboardSearch");

  if (searchForm) {

    searchForm.addEventListener("submit", function (e) {

      e.preventDefault();

    });
  }

  if (searchInput) {

    searchInput.addEventListener("keyup", function () {

      const value = this.value.toLowerCase();

      document
        .querySelectorAll(".sidebar-menu > .nav-item")
        .forEach(item => {

          const text =
            item.innerText.toLowerCase();

          item.style.display =
            text.includes(value) ? "" : "none";

        });

    });
  }


  /* =========================
     SIDEBAR SAVE STATE
  ========================= */
  if (
    localStorage.getItem("sidebar-collapse")
    === "true"
  ) {
    document.body.classList.add("sidebar-collapse");
  }

  const sidebarBtn =
    document.querySelector('[data-lte-toggle="sidebar"]');

  if (sidebarBtn) {

    sidebarBtn.addEventListener("click", function () {

      setTimeout(() => {

        const collapsed =
          document.body.classList.contains("sidebar-collapse");

        localStorage.setItem(
          "sidebar-collapse",
          collapsed
        );

      }, 200);

    });
  }


  /* =========================
     OVERLAY SCROLLBAR
  ========================= */
  const sidebarWrapper =
    document.querySelector(".sidebar-wrapper");

  const isMobile =
    window.innerWidth <= 992;

  if (
    sidebarWrapper &&
    window.OverlayScrollbarsGlobal &&
    !isMobile
  ) {

    OverlayScrollbarsGlobal.OverlayScrollbars(
      sidebarWrapper,
      {
        scrollbars: {
          theme: "os-theme-light",
          autoHide: "leave",
          clickScroll: true,
        },
      }
    );
  }


  /* =========================
     SORTABLE
  ========================= */
  const sortableElement =
    document.querySelector(".connectedSortable");

  if (sortableElement && window.Sortable) {

    new Sortable(sortableElement, {
      group: "shared",
      handle: ".card-header",
    });

    document
      .querySelectorAll(".connectedSortable .card-header")
      .forEach(cardHeader => {

        cardHeader.style.cursor = "move";

      });
  }


  /* =========================
     LINE CHART
  ========================= */
  const sales_chart_options = {

    series: [
      {
        name: "Performance",
        data: [28, 48, 40, 19, 86, 27, 90],
      },
      {
        name: "Projects",
        data: [65, 59, 80, 81, 56, 55, 40],
      },
    ],

    chart: {
      height: 300,
      type: "area",
      toolbar: {
        show: false,
      },
    },

    legend: {
      show: false,
    },

    colors: ["#4F46E5", "#22C55E"],

    dataLabels: {
      enabled: false,
    },

    stroke: {
      curve: "smooth",
    },

    xaxis: {
      type: "datetime",
      categories: [
        "2023-01-01",
        "2023-02-01",
        "2023-03-01",
        "2023-04-01",
        "2023-05-01",
        "2023-06-01",
        "2023-07-01",
      ],
    },
  };

  if (document.querySelector("#revenue-chart")) {

    new ApexCharts(
      document.querySelector("#revenue-chart"),
      sales_chart_options
    ).render();
  }


  /* =========================
     BAR CHART
  ========================= */
  const barOptions = {

    series: [{
      name: "Projects",
      data: [10, 15, 12, 18, 20, 14]
    }],

    chart: {
      type: "bar",
      height: 300,
      toolbar: {
        show: false
      }
    },

    colors: ["#4F46E5"],

    xaxis: {
      categories: ["P1", "P2", "P3", "P4", "P5", "P6"]
    }
  };

  if (document.querySelector("#bar-chart")) {

    new ApexCharts(
      document.querySelector("#bar-chart"),
      barOptions
    ).render();
  }


  /* =========================
     PIE CHART
  ========================= */
  const pieOptions = {

    series: [40, 30, 20, 10],

    chart: {
      type: "pie",
      height: 300
    },

    labels: [
      "Completed",
      "Pending",
      "In Progress",
      "Hold"
    ],

    colors: [
      "#22C55E",
      "#F59E0B",
      "#3B82F6",
      "#EF4444"
    ]
  };

  if (document.querySelector("#pie-chart")) {

    new ApexCharts(
      document.querySelector("#pie-chart"),
      pieOptions
    ).render();
  }

});

  const current = document.documentElement.getAttribute("data-theme");

  if (current === "dark") {
    document.documentElement.removeAttribute("data-theme");
  } else {
    document.documentElement.setAttribute("data-theme", "dark");
  }