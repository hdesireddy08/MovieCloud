import { api, LightningElement } from "lwc";
import LOCALE from "@salesforce/i18n/locale";
import TIME_ZONE from '@salesforce/i18n/timeZone';
import getGenres from "@salesforce/apex/MovieCloudController.getGenres";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class MovieCloudFilter extends LightningElement {
  sortOptions = [
    {
      label: "Popularity Descending",
      value: "popularity.desc"
    },
    {
      label: "Popularity Ascending",
      value: "popularity.asc"
    },
    {
      label: "Rating Descending",
      value: "vote_average.desc"
    },
    {
      label: "Rating Ascending",
      value: "vote_average.asc"
    },
    {
      label: "Release Date Descending",
      value: "release_date.desc"
    },
    {
      label: "Release Date Ascending",
      value: "release_date.asc"
    },
    {
      label: "Title (A-Z)",
      value: "original_title.asc"
    },
    {
      label: "Title (Z-A)",
      value: "original_title.desc"
    }
  ];
  genres = [];
  selectedGenres = [];
  @api language = "en-US";
  @api sortBy = "vote_average.desc";
  @api minimumUserVotes = 300;
  @api minimumUserScore = 0;
  @api maximumUserScore = 10;
  @api minimumRuntime = 0;
  @api maximumRuntime = 400;
  @api fromReleaseDate = null;
  @api toReleaseDate =  new Intl.DateTimeFormat(LOCALE, { timeZone: TIME_ZONE }).format(new Date());

  async connectedCallback() {
    try {
      const response = await getGenres({ language: this.language });
      this.genres = response.genres;
    } catch (error) {
      this.handleError(error);
    }
  }

  handleValueChange(event) {
    const { value } = event.target;
    const { name } = event.target.dataset;
    this[name] = value;
    this.filtersUpdated();
  }

  handleGenreClick(event) {
    const { id } = event.target.dataset;
    if (!this.selectedGenres.includes(id)) {
      this.selectedGenres.push(id);
      this.template.querySelector(`[data-id="${id}"]`).classList.add("slds-theme_success");
    } else {
      this.selectedGenres = this.selectedGenres.filter(genreId => genreId !== id);
      this.template.querySelector(`[data-id="${id}"]`).classList.remove("slds-theme_success");
    }
    this.filtersUpdated();
  }

  filtersUpdated() {
    this.dispatchEvent(new CustomEvent("filterchange", {
      detail: {
        sortBy: this.sortBy,
        genres: this.selectedGenres,
        minimumUserVotes: this.minimumUserVotes,
        minimumUserScore: this.minimumUserScore,
        maximumUserScore: this.maximumUserScore,
        minimumRuntime: this.minimumRuntime,
        maximumRuntime: this.maximumRuntime,
        fromReleaseDate: this.fromReleaseDate,
        toReleaseDate: this.toReleaseDate
      }
    }));
  }

  handleError(error) {
    this.errorMessage = error.body.message || error.message || JSON.stringify(error);
    this.dispatchEvent(new ShowToastEvent({
      title: "Error",
      message: this.errorMessage,
      variant: "error"
    }));
  }
}