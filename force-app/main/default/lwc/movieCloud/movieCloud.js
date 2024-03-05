import { LightningElement } from "lwc";
import getMovies from "@salesforce/apex/MovieCloudController.getMovies";
import BASE_IMAGE_URL from "@salesforce/label/c.tmdb_base_image_url";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import LOCALE from "@salesforce/i18n/locale";
import TIME_ZONE from '@salesforce/i18n/timeZone';

export default class MovieCloud extends LightningElement {
  currentPage = 1;
  totalPage = 0;
  totalResults = 0;
  movies = [];
  errorMessage = null;
  loading = false;
  label = {
    BASE_IMAGE_URL
  };
  filters = {
    genres: [],
    sortBy: "vote_average.desc",
    language: "en",
    minimumUserVotes: 300,
    minimumUserScore: 0,
    maximumUserScore: 10,
    minimumRuntime: 0,
    maximumRuntime: 400,
    fromReleaseDate: null,
    toReleaseDate: new Intl.DateTimeFormat(LOCALE, { timeZone: TIME_ZONE }).format(new Date())
  };

  get filterParameters() {
    let parameters = {
      "include_adult": false,
      "include_video": false,
      "language": this.filters.language,
      "page": this.currentPage,
      "sort_by": this.filters.sortBy,
      "vote_average.gte": this.filters.minimumUserScore,
      "vote_average.lte": this.filters.maximumUserScore,
      "vote_count.gte": this.filters.minimumUserVotes,
      "with_runtime.gte": this.filters.minimumRuntime,
      "with_runtime.lte": this.filters.maximumRuntime,
    };
    if (this.filters.fromReleaseDate) {
      parameters["primary_release_date.gte"] = this.filters.fromReleaseDate;
    }
    if (this.filters.toReleaseDate) {
      parameters["primary_release_date.lte"] = this.filters.toReleaseDate;
    }
    if (this.filters.genres && this.filters.genres.length > 0) {
      parameters.with_genres = this.filters.genres.join(",");
    }
    console.log(parameters);
    return parameters;
  }

  get hasMoreMovies() {
    return this.currentPage < this.totalPage || false;
  }

  get isLoadMoreDisabled() {
    return this.loading || !this.hasMoreMovies ? "disabled" : "";
  }

  async connectedCallback() {
    await this.loadMovies();
  }

  async loadMovies() {
    this.loading = true;
    try {
      const response = await getMovies({
        parameters: this.filterParameters
      });
      response.results = response.results.map(movie => {
        movie.poster_path = this.label.BASE_IMAGE_URL + movie.poster_path;
        movie.backdrop_path = this.label.BASE_IMAGE_URL + movie.backdrop_path;
        return movie;
      });
      this.movies = [...this.movies, ...response.results];
      this.totalPage = response.total_pages || 0;
      this.totalResults = response.total_results || 0;
    } catch (error) {
      this.handleError(error);
    }
    this.loading = false;
  }

  handleError(error) {
    this.errorMessage = error.body?.message || error.message || JSON.stringify(error);
    this.dispatchEvent(new ShowToastEvent({
      title: "Error",
      message: this.errorMessage,
      variant: "error"
    }));
  }

  handleLoadMore() {
    if (this.hasMoreMovies) {
      this.currentPage++;
      this.loadMovies();
    }
  }

  handleFilterChange(event) {
    this.filters = { ...event.detail };
    this.handleRefresh();
  }

  handleRefresh() {
    this.movies = [];
    this.currentPage = 1;
    this.loadMovies();
  }

}